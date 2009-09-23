class CreateSystemDatas < ActiveRecord::Migration
  def self.up
    create_table :system_datas do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :system_datas
  end
end
