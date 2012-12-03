class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email1, null:false
      t.string :email2
      t.string :nick
      t.string :subdomain, null:false
      t.integer :sponsor_id, null:false
      t.string :password_digest, null:false
      t.integer :status # {0:pending, 1:active, 2:inactive, 3:suspended, 4: excluded}
      t.timestamps
    end
  end
end
