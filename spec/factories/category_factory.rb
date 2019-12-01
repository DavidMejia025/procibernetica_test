FactoryBot.define do
  factory :category do
    association :task, factory: :task

    id   { 0 }
    name { "Default" }
  end
end
