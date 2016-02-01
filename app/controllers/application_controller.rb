﻿class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def after_sign_in_path_for(resource)
    if resource.is_a?(Optimacms::CmsAdminUser)
      cms.dashboard_path
    else
      root_path
    end
  end


  def addcmsuser
    return

    row = Optimacms::CmsAdminUser.new
    row.email = 'admin@example.com'
    row.password = 'password'

    row.save

  end

  # exceptions

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end


  def render_error(status, exception)
    $Mylog.log_event 'error', 'exception', "#{status}, url: #{request.original_url}, referer: #{request.env["HTTP_REFERER"]}, ip: #{request.env["REMOTE_ADDR"]}, #{request.env["HTTP_X_FORWARDED_FOR"]}, #{exception.inspect}, #{(exception.backtrace || []).join('\n').truncate(8000)}"

    respond_to do |format|
      format.html { render template: "errors/error_#{status}", status: status }
      format.all { render nothing: true, status: status }
    end
  end



end
