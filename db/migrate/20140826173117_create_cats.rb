class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name, null: false
      t.integer :age
      t.date :birth_date
      t.string :color
      t.string :sex
      t.text :description

      t.timestamps
    end
    
    add_index :cats, :name
  end
end
