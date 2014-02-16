class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :team, index: true
      t.string :userapp_id

      t.timestamps
    end
  end
end
