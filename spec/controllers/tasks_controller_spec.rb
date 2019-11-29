require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "#create" do
    subject { get :create, params: param }

    context "when task can be created" do
      let!(:param) { {task: {title: "Clean apartment"}} }

      it "tasks counter increased by one" do
        expect {
          subject
        }.to change(Task.all, :count).by(1)
      end

      it "flash success message" do
        subject
        expect(flash[:success]).to match(/New Task was Successfully created/)
      end

      it { is_expected.to redirect_to(action: :index) }
    end

    context "when task can not be created" do
      let!(:param) { {task: {name: "Nothing"}} }

      it "number of tasks does not change" do
        expect {
          subject
          }.to change(Task.all, :count).by(0)
      end

      it "flash error message" do
        subject
        expect(flash[:error]).to match(/New Task could not be created/)
      end

      it { is_expected.to redirect_to(action: :new) }
    end
  end

  describe "#show" do
    let!(:task) { create :task }

    subject { get :show, params: param.merge({:format => 'js'}) }

    context "when task can be fetch" do
      let(:param) { {id: 1} }

      it "renders js template" do
      end
    end

    context "when task can not be fetch" do
      let(:param) { {id: 10} }

      context "when task does not exist" do
        it "flash error message" do
          subject
          expect(flash[:error]).to match(/Task with id 10 does not exist/)
        end

        it { is_expected.to redirect_to(action: :index) }
      end
    end
  end

  describe "#update" do
    let!(:task) { create :task }

    subject { get :update, params: param }

    context "when task can be updated" do
      let!(:param) { {id: 1, task: {title: "Go to the stadium on Sunday", status: :done}} }
      context "update title" do

        it "task title change" do
          expect {
            subject
          }.to change {
            task.reload.title
          }.to("Go to the stadium on Sunday")
        end
      end

      context "update status" do
        it "status change to done" do
          expect {
            subject
          }.to change {
            task.reload.status
          }.to("done")
        end
      end

      it "flash success message" do
        subject
        expect(flash[:success]).to match(/Go to the stadium on Sunday task was Successfully updated and now is done/)
      end
    end

    context "when task can not be updated" do
      let!(:param) { {id: id, task: {title: title, status: status}} }
      let(:id)     { 1 }
      let(:title)  { "Some Default title" }
      let(:status) { :done }

      context "when title is empty" do
        let(:title)  { nil }

        it "flash error message" do
          subject
          expect(flash[:error]).to match(/Task could not be updated/)
        end

        it { is_expected.to redirect_to(action: :index) }
      end

      context "when status does not exist" do
        let(:status) { :not_yet }

        it "flash error message" do
          subject
          expect(flash[:error]).to match(/Task could not be updated/)
        end

        it { is_expected.to redirect_to(action: :index) }
      end

      context "when task does not exist" do
        let(:id) { 100 }

        it "flash error message" do
          subject
          expect(flash[:error]).to match(/Task with id 100 does not exist/)
        end

        it { is_expected.to redirect_to(action: :index) }
      end
    end
  end
end
