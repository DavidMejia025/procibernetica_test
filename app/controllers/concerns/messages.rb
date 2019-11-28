module Messages
  extend ActiveSupport::Concern

  def not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def task_created
    'New Task was created successfully'
  end
end
