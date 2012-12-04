class CreateVisitCounters < ActiveRecord::Migration
  def change
    create_table :visit_counters do |t|
      t.integer :count, null:false, default:0
      t.references :user

      t.timestamps
    end
    add_index :visit_counters, :user_id
  end
end
