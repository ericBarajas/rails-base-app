# This migration comes from callback_form (originally 20141213011430)
class AddPhoneToCallbackFormRequests < ActiveRecord::Migration
  def change
    add_column :callback_form_requests, :phone, :string
  end
end
