class CreateStudytimes < ActiveRecord::Migration[7.1]
  def change
    create_table :studytimes do |t|
      t.integer :studytime_hours
      t.integer :studytime_minutes
      t.text :memo

      t.timestamps
    end
  end
end
