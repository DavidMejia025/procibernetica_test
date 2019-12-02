class NotificationService
  NOTIFICATION = {
    create: ["SlackService"],
    update: ["SlackService"],
    delete: ["SlackService"],
  }.freeze

  def self.notify(event:, message:)
    NOTIFICATION[event].each do|notification|
      notification.constantize.send("send_message", message: message)
    end
  end
end
