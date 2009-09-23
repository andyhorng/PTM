class CreateHours < ActiveRecord::Migration
  def self.up
    create_table :hours do |t|
      t.string :semester_type
      t.integer :week_hours
      t.integer :hourly_money
      t.integer :total_hours
      t.date :from
      t.date :to
      t.integer :student_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hours
  end
end
