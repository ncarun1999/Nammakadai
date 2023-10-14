ActiveAdmin.register Product do
  permit_params :name, :category, :description, :short_description, :image, :cost, :additional_details, :is_active, :created_by_id, :created_by_type, active_for: []

  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)

    f.inputs 'Product Details' do
      f.input :name
      f.input :category, input_html: { style: 'width: 300px;' }
      f.input :description
      f.input :short_description
      f.input :image
      f.input :additional_details
      f.input :cost
    end

    f.inputs 'Active Status' do
      f.input :is_active
      f.input :active_for, as: :select, collection: Product.categories, input_html: { multiple: true, size: 5, style: 'width: 300px;' }
    end

    f.inputs 'Active Status' do
      f.input :created_by_type, input_html: { value: User }, as: :hidden
      f.input :created_by_id, as: :select, collection: User.all, selected: current_user.id, input_html: { style: 'width: 300px;' }
    end
    f.actions
  end

end