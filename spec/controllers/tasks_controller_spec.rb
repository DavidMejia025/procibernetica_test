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
end
