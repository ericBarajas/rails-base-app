class SiteBaseController  < BaseController


  ### custom for application
  before_filter :my_before_page_render


  def my_before_page_render
    #set_locale

  end




end
