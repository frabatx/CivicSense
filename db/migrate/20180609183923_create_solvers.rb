class CreateSolvers < ActiveRecord::Migration[5.1]
  def change
    create_table :solvers do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :phone_number, null: false
      t.integer :user_id, null: false
      t.integer :administration_id, null: false
    end
  end
end
