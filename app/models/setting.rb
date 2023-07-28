class Setting < ApplicationRecord
  def self.[](name)
    name = name.to_s.parameterize.underscore.upcase
    setting = find_by_name(name)

    case setting.value_type.downcase
    when 'integer'
      setting.value.to_i
    when 'float'
      setting.value.to_f
    when 'json'
      JSON.parse(setting.value)
    when 'boolean'
      ActiveModel::Type::Boolean.new.cast(setting.value)
    else
      setting.value.to_s
    end
  end
end
