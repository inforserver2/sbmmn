class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :redir_from
      t.references :user, null:false

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
