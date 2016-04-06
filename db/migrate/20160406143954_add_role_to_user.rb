class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, limit: 20, null: false, default: 'student'
  end
end
