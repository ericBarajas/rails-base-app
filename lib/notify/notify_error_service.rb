module Notify
  class NotifyErrorService

    def self.notify_exception(ex, request)
      msg = build_message_from_exception  ex, request
      Notify::SlackService.send_message 'errors', Rails.application.secrets.slack[:errors][:channel], msg
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
          :type => :attachment,
          :data =>
              [{
                   pretext: "[#{Rails.application.config.SITE_NAME}::#{Rails.env}] Exception",
                   title: "Exception #{Time.now}",
                   text: text,
                   fallback: "Exception",
                   color: Notify::SlackService::COLORS[:primary],

               }]
      }
    end

  end
end
