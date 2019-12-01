require 'rails_helper'

RSpec.describe QueryService, type: :service do
  describe "#query" do
    let!(:task1) { create(:task, id: 1, title: "Today is monday") }
    let!(:task2) { create(:task, id: 2, title: "Sunday is my fav day") }
    let!(:tasks) { [task1, task2] }

    subject { described_class.query(tasks: tasks, search_input: search_input) }

    context "when tasks includes records that matches search_input param" do
      let(:search_input) { "monday" }

      it "return some records" do
        expect(subject).to include(task1)
      end
    end

    context "when tasks includes does not include records that matches search input param" do
      let(:search_input) { "tuesday" }

      it "return empty array" do
        expect(subject).to eq([])
      end
    end
  end
end
