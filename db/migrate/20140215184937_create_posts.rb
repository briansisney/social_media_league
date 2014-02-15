class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :page, index: true
      t.string :text




      t.timestamps
    end
  end
end
