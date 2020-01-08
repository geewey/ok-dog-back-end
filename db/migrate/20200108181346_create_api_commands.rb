class CreateApiCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :api_commands do |t|
      t.integer :api_id
      t.integer :command_id

      t.timestamps
    end
  end
end
