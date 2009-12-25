class SystemDataSecondVersion < ActiveRecord::Migration
  def self.up
    remove_column :system_datas, :value

    create_table "system_data_values" do |t|
      t.integer :system_data_id
      t.string :value

      t.timestamps
    end

  end

  def self.down
    add_column :system_datas, :value, :string
    drop_table :system_data_values
  end
end
