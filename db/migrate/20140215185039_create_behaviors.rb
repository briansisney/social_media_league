class CreateBehaviors < ActiveRecord::Migration
  def change
    create_table :behaviors do |t|
      t.references :user, index: true
      t.references :post, index: true
      t.string :behavior_type
      t.string :facebook_id

      t.timestamps
    end
  end
end
