class NotificationService
  NOTIFICATION = {
    create: ["SlackService", "MailerService"],
    update: ["SlackService"],
    delete: ["SlackService", "MailerService"]
  }.freeze

  def self.notify(task:, event:)
    message = task.notification_message(event: event)

    NOTIFICATION[event].each do|notification|
      notification.constantize.send("send_message", message: message)
    end
  end
end
