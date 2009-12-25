class AddColumnsToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :pt_type, :string
    add_column :students, :money_source, :string
  end

  def self.down
    remove_column :students, :pt_type
    remove_column :students, :money_source
  end
end
