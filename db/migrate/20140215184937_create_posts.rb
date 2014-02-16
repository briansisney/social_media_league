class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :page, index: true
      t.string :entry_id
      t.string :type


      t.timestamps
    end
  end
end
