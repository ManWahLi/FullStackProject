class ReviewCustomersColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :username
    remove_column :customers, :password
    remove_column :customers, :email_address
  end
end
