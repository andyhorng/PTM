class MoveColumnsFromStudentToHour < ActiveRecord::Migration
  def self.up
    add_column :hours, :money_source, :string
    add_column :hours, :pt_type, :string

    remove_column :students, :money_source
    remove_column :students, :pt_type
  end

  def self.down
    remove_column :hours, :money_source
    remove_column :hours, :pt_type

    add_column :students, :money_source, :string
    add_column :students, :pt_type, :string
  end
end
