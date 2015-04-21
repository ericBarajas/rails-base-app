# This migration comes from callback_form (originally 20141213000908)
class CreateCallbackFormRequests < ActiveRecord::Migration
  def change
    create_table :callback_form_requests do |t|
      t.string :name
      t.string :email
      t.text :notes

      t.timestamps
    end
  end
end
