class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :name
      t.string :student_number
      t.string :department
      t.string :id_number
      t.string :phone_number
      t.text :address
      t.string :post_office_account
      t.string :post_office_number
      t.decimal :school_score
      t.text :memo

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
