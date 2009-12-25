class AddSystemData < ActiveRecord::Migration
  def self.up
    SystemData.create(:name => 'money_source')
    SystemData.create(:name => 'pt_type')
  end

  def self.down
    SystemData.find_by_name('money_source').delete
    SystemData.find_by_name('pt_type').delete
  end
end
