class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name
      t.datetime :license_issued
      t.boolean :renew_license
      t.integer :max_students

      t.timestamps
    end
  end
end
