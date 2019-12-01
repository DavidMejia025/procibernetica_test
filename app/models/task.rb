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

class Task < ApplicationRecord
  after_initialize :set_default_role, if: :new_record?

  has_many    :comments
  belongs_to  :category

  validates :title, presence: true

  enum status: %i[to_do done]

  scope :by_status, -> (status) do
    status = status == :to_do ? 0 : 1

    where('status = ?', status)
  end

  def set_default_role
    self.status ||= :to_do
  end
end
