class ChangeProvinceColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :provinces, :province_code
    remove_column :provinces, :province_tax_rate
    add_column :provinces, :gst, :decimal
    add_column :provinces, :hst, :decimal
    add_column :provinces, :qst, :decimal
    add_column :provinces, :pst, :decimal
  end
end
