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

require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  
  it { should belong_to(:category) }
end
