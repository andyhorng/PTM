class AddAdministrator < ActiveRecord::Migration
  def self.up
    Administrator.create(:login => 'andy', :password => 'andy', :password_confirmation => 'andy')
  end

  def self.down
    Administrator.find_by_login('andy').delete
  end
end
