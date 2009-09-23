class ModifyAdministratorTable < ActiveRecord::Migration
  def self.up
    rename_column :administrators, :name, :login
  end

  def self.down
    rename_column :administrators, :login, :name
  end
end
