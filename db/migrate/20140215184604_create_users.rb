class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.references :team, index: true
      t.string :facebook_id

      t.timestamps
    end
  end
end
