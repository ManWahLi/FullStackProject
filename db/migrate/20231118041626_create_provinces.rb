class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces do |t|
      t.string :province_code
      t.string :province_name
      t.decimal :province_tax_rate

      t.timestamps
    end
  end
end
