class AddAuthColumns < ActiveRecord::Migration
  def self.up
    add_column :administrators, :crypted_password, :string
    add_column :administrators, :password_salt, :string
    add_column :administrators, :persistence_token, :string
  end

  def self.down
    remove_column :administrators, :crypted_password
    remove_column :administrators, :password_salt
    remove_column :administrators, :persistence_token
  end
end
