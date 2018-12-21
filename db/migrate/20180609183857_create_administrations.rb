class CreateAdministrations < ActiveRecord::Migration[5.1]
  def change
    create_table :administrations do |t|
      t.string :name, null: false
      t.string :phone_number, null: false
      t.string :city, null: false
      t.string :province, null: false
      t.string :street, null: false
      t.integer :user_id, null: false
    end
  end
end
