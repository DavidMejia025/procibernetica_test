class SlackService < NotificationService
  CHANNEL = "#general".freeze

  def self.send_message(message:)
    if false
    #if Rails.env.production?
      slack = Slack::Notifier.new(ENV["SLACK_URL"])

      attachhment = {text: message}

      slack_response = slack.ping(channel: channel, attachments: [attachment])
    else
      puts "Slack message for chanel: #{CHANNEL} with attachment: #{message}"
    end
  end
end
