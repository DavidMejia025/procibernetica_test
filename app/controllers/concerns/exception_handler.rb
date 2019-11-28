module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
  end

  private

  def four_twenty_two(e)
    json_response({ message: e.errors.full_messages }, :unprocessable_entity)
  end
end
