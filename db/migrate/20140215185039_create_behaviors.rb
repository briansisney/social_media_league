class CreateBehaviors < ActiveRecord::Migration
  def change
    create_table :behaviors do |t|
      t.references :user, index: true
      t.references :post, index: true
      t.string :type

      t.timestamps
    end
  end
end
