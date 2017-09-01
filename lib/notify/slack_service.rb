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

      @@client = Slack::Notifier.new Rails.application.secrets.slack[:errors][:webhook_url] do
        defaults channel: Rails.application.secrets.slack[:errors][:channel],
                 username: Rails.application.secrets.slack[:errors][:username]
      end

      return @@client
    end



    def self.notify_exception(ex, request)
      client = get_client

      #
      msg = build_message_from_exception  ex, request

      send_message Rails.application.secrets.slack_notify_channel, msg

    end

    def self.send_message(channel, msg)
      if msg[:type]==:text
        get_client.post(channel: [channel], text: msg[:text])
      else
        get_client.post(channel: [channel], attachments: msg[:att])
      end
    end


    ### message common

    def self.build_message_system(request)
      data = {
          app: Rails.application.config.SITE_NAME,
          url: request.original_url,
          referer: request.env["HTTP_REFERER"],
          ip: "#{request.env["REMOTE_ADDR"]}, #{request.env["HTTP_X_FORWARDED_FOR"]}",
      }
    end


    ### exception

    def self.build_message_text_from_exception(ex, request)
      sys_data = build_message_system(request)
      <<-EOF
#{sys_data.map{|k,v| "#{k}: #{v}"}.join("\n")}      
Message: #{ex.message}
Backtrace: #{ex.backtrace.inspect}
      EOF
    end

    def self.build_message_from_exception(ex, request)
      text = build_message_text_from_exception(ex, request)

      {
          :type => :att,
          :att =>
              [{
                   pretext: "[#{Rails.application.config.SITE_NAME}::#{Rails.env}] Exception",
                   title: "Exception #{Time.now}",
                   text: text,
                   fallback: "Exception",
                   color: COLORS[:primary],

               }]
      }
    end

  end
end
