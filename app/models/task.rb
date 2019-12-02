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

class Task < ApplicationRecord
  after_initialize :set_default_values, if: :new_record?

  has_many    :comments
  belongs_to  :category

  validates :title, presence: true

  enum status: %i[to_do done]

  scope :by_status, -> (status) do
    status = status == :to_do ? 0 : 1

    where('status = ?', status)
  end

  def set_default_values
    self.status   ||= :to_do
    self.deadline ||= (Date.today  + 1.year)
  end
end
