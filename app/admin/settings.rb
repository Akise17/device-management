ActiveAdmin.register Setting do
  permit_params :name, :value, :value_type, :description  
end
