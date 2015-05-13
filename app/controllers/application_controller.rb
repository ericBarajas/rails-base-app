class ApplicationController < ActionController::Base
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
    row = Optimacms::CmsAdminUser.new
    row.email = 'admin@example.com'
    row.password = 'password'

    row.save

  end



end
