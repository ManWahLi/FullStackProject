ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :price, :image_link, :rating, :category_id, :brand_id,
                :product_type_id, product_tags_attributes: %i[id product_id tag_id _destroy]
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :image_link, :rating, :category_id, :brand_id, :product_type_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    column :id
    column :name
    column :price
    column :rating
    column :category
    column :brand
    column :product_type
    column :tags do |p|
      p.tags.map { |t| t.name }.join(", ").html_safe
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :image_link
      row :rating
      row :category_id
      row :brand_id
      row :product_type_id
      row :tags do |p|
        p.tags.map { |t| t.name }.join(", ").html_safe
      end
    end
  end

  form do |f|
    f.semantic_errors # f.object.errors.keys
    f.inputs
    f.inputs do
      f.has_many :product_tags, allow_destroy: true do |n_f|
        n_f.input :tag
      end
    end
    f.actions
  end
end
