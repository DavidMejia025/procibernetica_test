# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  title      :string
#  done       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer
#
'require faker'

FactoryBot.define do
  factory :task do
    id     { 1 }
    title  { "go to the gym" }
  end
end
