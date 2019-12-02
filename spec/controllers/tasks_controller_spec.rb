require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "#index" do
    let!(:to_do_task)  { create(:task) }
    let!(:done_task)   { create(:task, id: 2, title: "go to the supermarket", status: "done") }
    let(:search_input) { nil }

    subject { get :index, params: {search_input: search_input} }

    context "fetch Tasks data" do
      context "when search_input param is included " do

        it "calls QueryService" do
          expect(QueryService).to receive(:query).exactly(2).times
          subject
        end

        context "and do not match any record" do
          let(:search_input) { "foo" }

          it "return empty array for to_do and done tasks" do
            subject
            expect(assigns(:to_do_tasks)).to eq([])
            expect(assigns(:done_tasks)).to eq([])
          end
        end

        context "and do not match only one record" do
          let(:search_input) { "supermarket" }

          it "return empty array for to_do and done tasks" do
            subject
            expect(assigns(:to_do_tasks)).to eq([])
            expect(assigns(:done_tasks)).to eq([done_task])
          end
        end
      end

      context "when search_input param is not included" do
        it "assign tasks with status to_do to @to_do_tasks" do
          subject
          expect(assigns(:to_do_tasks)).to eq([to_do_task])
        end

        it "assign tasks with status to_do to @to_do_tasks" do
          subject
          expect(assigns(:done_tasks)).to eq([done_task])
        end
      end
    end
  end

  describe "#destroy" do
    let(:task) { create(:task, id: 1) }
    let!(:param) { {id: 1} }

    subject { delete :destroy, params: param }

    context "when Tasks exist" do
      before { allow(NotificationService).to receive(:notify).and_return(true) }

      it "deletes the user" do
        expect {
          subject
        }.to change(Task.all, :count).by(-1)
      end

      it "calls notifification service with delete event" do
        expect(NotificationService).to receive(:notify).with({task: task, event: :delete})
        subject
      end
    end

    context "when task does not exist" do
      it "flash error message" do
        subject
        expect(flash[:error]).to match(/Task with id 1 does not exist/)
      end

      it { is_expected.to redirect_to(action: :index) }
    end
  end

  describe "#create" do
    let!(:category) { (create :category, id: 1) }

    subject { get :create, params: param }

    context "when task can be created" do
      let!(:param) { {task: {title: "Clean apartment", category_id: 1}} }

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

      it { is_expected.to redirect_to(action: :index) }
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
    let!(:task) { (create :task, id: 1) }

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
