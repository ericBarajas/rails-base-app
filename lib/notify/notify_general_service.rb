module Notify
  class NotifyGeneralService

    def self.notify_event(event, request=nil)
      msg = build_message  event, request
      Notify::SlackService.send_message 'general', Rails.application.secrets.slack[:general][:channel], msg
    end


    ### message

    def self.build_request_data(request)
      return {} if request.nil?

      data = {
          app: Rails.application.config.SITE_NAME,
          url: request.original_url,
          referer: request.env["HTTP_REFERER"],
          ip: "#{request.env["REMOTE_ADDR"]}, #{request.env["HTTP_X_FORWARDED_FOR"]}",
      }
    end



    def self.build_message(event, request)
      sys_data = build_request_data(request)

      text = <<-EOF
Event: #{event.to_s}
Date: #{Time.now}
#{sys_data.map{|k,v| "#{k}: #{v}"}.join("\n")}
      EOF

      msg_title = event.to_s

      {
          :type => :attachment,
          :data =>
              [{
                   pretext: "[#{Rails.application.config.SITE_NAME}::#{Rails.env}] event",
                   title: msg_title,
                   text: text,
                   fallback: "event",
                   color: Notify::SlackService::COLORS[:primary],
               }]
      }
    end

  end
end
