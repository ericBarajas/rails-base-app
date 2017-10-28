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
                title: 'Backups', route: nil,
                submenu: [
                    {title: 'Backups', url: '/'+Optimacms.admin_namespace+'/backups' },
                ]
            }


        ]
      end

    end
  end
end
