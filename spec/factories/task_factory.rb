# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :integer
#  description :text
#  deadline    :date
#  category_id :integer          default(0)
#
FactoryBot.define do
  factory :task do
    category

    title  { "go to the gym" }
    status { "to_do" }
  end
end
