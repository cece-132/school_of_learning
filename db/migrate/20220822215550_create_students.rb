class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.boolean :otg
      t.integer :max_classes
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
