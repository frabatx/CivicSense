class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :role, default: 1, null: false
    end
  end
end

# Use Roles
# 1 = Super User
# 2 = Administration
# 3 = Solver
