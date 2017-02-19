module Optimacms
  module AdminMenu
    class AdminMenu
      include Optimacms::Concerns::AdminMenu::AdminMenu

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


        ]
      end

    end
  end
end
