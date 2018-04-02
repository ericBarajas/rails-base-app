class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  ### devise
  def after_sign_in_path_for(resource)
    if resource.is_a?(Optimacms::CmsAdminUser)
      cms.dashboard_path
    else
      root_path
    end
  end


  # exceptions

  #unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  #end



  def render_error(status, exception)
    #$Mylog.log_event 'error', 'exception', "#{status}, url: #{request.original_url}, referer: #{request.env["HTTP_REFERER"]}, ip: #{request.env["REMOTE_ADDR"]}, #{request.env["HTTP_X_FORWARDED_FOR"]}, #{exception.inspect}, #{(exception.backtrace || []).join('\n').truncate(8000)}"

    # log error
    begin
      Notify::NotifyErrorService.notify_exception(exception, request)
    rescue => e
      logger.info "Exception: #{exception.message}, #{exception.backtrace}"
      logger.info "Exception: #{e.message}, #{e.backtrace}"
    end





    unless Rails.application.config.consider_all_requests_local
      #
      respond_to do |format|
        format.html { render template: "errors/error_#{status}", status: status }
        format.all { render nothing: true, status: status }
      end
    else
      raise exception
    end
  end



  ### callbacks for CMS
  def before_page_render
    #set_locale

  end


  ### locale

  def set_locale
    @lang = params[:lang] || 'en'
    params[:lang] ||= @lang

    # set locale
    I18n.locale = @lang.to_sym

  end

end
