class ChangeCustomerProvinceForeignKeyConstraint < ActiveRecord::Migration[7.0]
  def change
    change_column_null :customers, :province_id, true
  end
end
