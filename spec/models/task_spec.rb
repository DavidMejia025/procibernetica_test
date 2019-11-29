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

require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to validate_presence_of(:title) }
end
