class CreateScreams < ActiveRecord::Migration[5.1]
  def change
    create_table :screams, id: :string do |t|
      t.float :latitude, default: 0, null: false
      t.float :longitude, default: 0, null: false
      t.string :address, null: true
      t.string :description, null: false
      t.integer :priority, default: 1
      t.string :screamer_email, null: true
      t.integer :status, default: 1
      t.integer :category_id, null: false
      t.integer :solver_id, null: true
      t.integer :administration_id, null: false
      t.timestamps
    end
  end
end
