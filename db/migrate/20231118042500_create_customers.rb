class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :username
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :address
      t.string :city
      t.string :postal_code
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
