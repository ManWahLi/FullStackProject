class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :brands, :brand_name, :name
    rename_column :categories, :category_name, :name
    rename_column :product_types, :product_type_name, :name
    rename_column :products, :product_name, :name
    rename_column :colors, :color_name, :name
    rename_column :tags, :tag_name, :name
    rename_column :provinces, :province_name, :name
    rename_column :order_statuses, :status_name, :name
  end
end
