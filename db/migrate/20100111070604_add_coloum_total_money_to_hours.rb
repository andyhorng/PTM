class AddColoumTotalMoneyToHours < ActiveRecord::Migration
  def self.up
    add_column :hours, :total_money, :integer
  end

  def self.down
    remove_column :hours, :total_money
  end
end
