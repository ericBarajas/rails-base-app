module Optimacms
  module AdminMenu
    class AdminMenu
      include Optimacms::Concerns::AdminMenu::AdminMenu

      def self.make_page(t, u)
        {title: t, url: '/'+Optimacms.config.admin_namespace+u }
      end

      def self.get_menu_custom
        [

            {
                title: 'Settings', route: nil,
                submenu: [
                    {title: 'Settings', url: '/'+Optimacms.config.admin_namespace+'/options' },
                ]
            },

            {
                title: 'Backups', route: nil,
                submenu: [
                    {title: 'Backups', url: '/'+Optimacms.config.admin_namespace+'/backups' },
                ]
            }


        ]
      end

    end
  end
end
