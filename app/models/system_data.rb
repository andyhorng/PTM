class SystemData < ActiveRecord::Base

  has_many :system_data_values

  def self.all_values_of(name)
    d = SystemData.find_by_name(name)
    d.system_data_values.collect { |v| v.value }
  end

end
