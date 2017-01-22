module ApplicationHelper
  def link_page(pagename, args={})
    site_page_path(pagename, {lang: @lang}.merge(args))

  rescue => e
    nil
  end


  def paginate objects, options = {}
    options.reverse_merge!( theme: 'bootstrap4' )

    super( objects, options )
  end

end
