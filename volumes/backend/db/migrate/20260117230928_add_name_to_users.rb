class AddNameToUsers < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :name, :string, null: false, default: ""
    User.find_each { |user| user.update(name: user.email.split("@").first) }
  end

  def down
    remove_column :users, :name
  end
end
