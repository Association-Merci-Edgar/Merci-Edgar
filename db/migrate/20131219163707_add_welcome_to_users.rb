class AddWelcomeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :welcome_hidden, :boolean
  end
end
