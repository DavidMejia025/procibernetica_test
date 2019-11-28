require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "#create" do
    subject { get :create, params: param }

    context "when task can be created" do
      let!(:param) { {title: "Clean apartment"} }

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
      let!(:param) { {nothing: "foo"} }

      it "number of tasks does not change" do
        expect {
          subject
          }.to change(Task.all, :count).by(0)
      end

      it { is_expected.to redirect_to(action: :new) }
    end
  end

  describe "#show" do

    subject { get :show, params: param }

    context "when task can be fetch" do
      xit "returns status ok" do
        subject
        expect(response.status).to eq(200)
      end

      xit "" do
        subject
        expect(response.body).to eq("New Task was created successfully".to_json)
      end
    end

    context "when task can not be fetch" do
      context "when task does not exist" do
        xit "returns status 422" do
          subject
          expect(response.status).to eq(422)
        end

        xit "returns errors in the body " do
          subject
          expect(response.body).to eq(errors)
        end
      end
    end
  end
end
