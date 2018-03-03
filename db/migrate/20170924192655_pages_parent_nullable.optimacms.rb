# This migration comes from optimacms (originally 20170921104152)
class PagesParentNullable < ActiveRecord::Migration[5.1]
  def up
    change_column :cms_pages, :parent_id, :integer, :null => true

  end

end
