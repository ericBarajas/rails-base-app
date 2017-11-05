module Notify
  class SlackService
    COLORS = {
        primary: '1A237E',
        second: '#004D40',
        red: '#BF360C',
        orange: '#FF6F00'
    }

    @@client = nil

    def self.get_client(t='general')
      return @@client unless @@client.nil?

      slack_type = t.to_sym

      @@client = Slack::Notifier.new Rails.application.secrets.slack[slack_type][:webhook_url] do
        defaults channel: Rails.application.secrets.slack[slack_type][:channel],
                 username: Rails.application.secrets.slack[slack_type][:username]
      end

      return @@client
    end


    def self.send_message(type, channel, msg)
      if msg[:type]==:text
        get_client(type).post(channel: [channel], text: msg[:text])
      else
        # attachment
        get_client(type).post(channel: [channel], attachments: msg[:data])
      end
    end


  end
end
