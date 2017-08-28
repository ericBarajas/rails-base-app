module Notify
  class SlackService
    COLORS = {
        primary: '1A237E',
        second: '#004D40',
        red: '#BF360C',
        orange: '#FF6F00'
    }

    @@client = nil

    def self.get_client
      return @@client unless @@client.nil?

      @@client = Slack::Notifier.new Rails.application.secrets.slack_notify_webhook_url do
        defaults channel: Rails.application.secrets.slack_notify_channel,
                 username: Rails.application.secrets.slack_notify_username
      end

      return @@client
    end



    def self.notify_exception(ex)
      client = get_client

      #
      msg = build_message_from_exception  ex

      send_message Rails.application.secrets.slack_notify_channel, msg

    end

    def self.send_message(channel, msg)
      if msg[:type]==:text
        get_client.post(channel: [channel], text: msg[:text])
      else
        get_client.post(channel: [channel], attachments: msg[:att])
      end
    end



    ### exception

    def self.build_message_text_from_exception(ex)
      <<-EOF
Message: #{ex.message}
Backtrace: #{ex.backtrace.inspect}
      EOF
    end

    def self.build_message_from_exception(ex)
      text = build_message_text_from_exception(ex)

      {
          :type => :att,
          :att =>
              [{
                   pretext: "Exception",
                   title: "Exception #{Time.now}",
                   text: text,
                   fallback: "Exception",
                   color: COLORS[:primary],

               }]
      }
    end

  end
end
