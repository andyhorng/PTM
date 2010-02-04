class AddSystemData < ActiveRecord::Migration
  def self.up
    SystemData.create(:name => 'money_source')
    SystemData.create(:name => 'pt_type')
    dep = SystemData.create(:name => 'department')
    File.foreach("#{RAILS_ROOT}/db/department.list") do |d|
      SystemDataValue.create(:system_data => dep, :value => d)
    end
  end

  def self.down
    SystemData.find_by_name('money_source').delete
    SystemData.find_by_name('pt_type').delete
    SystemData.find_by_name('department').delete
  end
end
