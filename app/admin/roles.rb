ActiveAdmin.register Role do
  permit_params :name, :resource_type, :resource_id
  #
  # index do
  #   column :id
  #   column :name
  #   column :resource_id
  #   column :resource_type
  #
  #   actions
  # end
end
