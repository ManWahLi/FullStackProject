ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :price, :image_link, :rating, :category_id, :brand_id,
                :product_type_id, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :image_link, :rating, :category_id, :brand_id, :product_type_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  ## Edit object form
  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as:   :file,
                      hint: if f.object.image.present?
                              image_tag(f.object.image)
                            else
                              ""
                            end
    end
    f.actions
  end
end
