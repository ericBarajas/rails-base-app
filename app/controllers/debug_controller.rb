class DebugController < SiteBaseController
  layout 'basic'

  def index

  end

  def paginator
    @items = Optimacms::Page.page(1).per(3)
  end

end
