class MailerService < NotificationService
  def self.send_message(message:)
    puts "sending email to default address"
  end
end
