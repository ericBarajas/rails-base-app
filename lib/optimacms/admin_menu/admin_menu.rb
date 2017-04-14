module Optimacms
  module AdminMenu
    class AdminMenu
      include Optimacms::Concerns::AdminMenu::AdminMenu

      def self.make_page(t, u)
        {title: t, url: '/'+Optimacms.admin_namespace+u }
      end

      def self.get_menu_custom
        [
=begin
            {
                title: 'Catalog', route: nil,
                submenu: [
                    {title: 'Products', url: '/'+Optimacms.admin_namespace+'/products' },
                    {title: 'Categories', url: '/'+Optimacms.admin_namespace+'/categories' },
                ]
            },
=end


            {
                title: 'App data', route: nil,
                submenu: [
                    make_page('Deploy', '/deploy'),

                ]
            },


        ]
      end

    end
  end
end
