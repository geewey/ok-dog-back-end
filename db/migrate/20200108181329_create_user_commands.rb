class CreateUserCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :user_commands do |t|
      t.integer :user_id
      t.integer :command_id

      t.timestamps
    end
  end
end
