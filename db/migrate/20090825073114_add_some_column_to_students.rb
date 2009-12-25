class AddSomeColumnToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :email, :string
    add_column :students, :post_office_name, :string
    add_column :students, :home_tel, :string
    add_column :students, :work_tel, :string
  end

  def self.down
    remove_column :students, :email
    remove_column :students, :post_office_name
    remove_column :students, :home_tel
    remove_column :students, :work_tel
  end
end
