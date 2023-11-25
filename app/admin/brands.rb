ActiveAdmin.register Brand do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  ## Formtastic
  # <%= semantic_form_for @user do |f| %>
  #   <%= f.inputs %>
  #   <%= f.actions %>
  # <% end %>

  ## Customize form
  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as:   :file,
                      hint: if f.object.image.present?
                              image_tag(f.object.image.variant(resize_to_limit: [300, 300]))
                            else
                              ""
                            end
    end
    f.actions
  end
end
