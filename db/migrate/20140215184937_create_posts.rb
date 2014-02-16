class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :page, index: true
      t.string :entry_id
      t.string :post_type
      t.string :fb_created_time


      t.timestamps
    end
  end
end
