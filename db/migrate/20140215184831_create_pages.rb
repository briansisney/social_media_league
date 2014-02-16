class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :user, index: true
      t.string :type
      t.string :facebook_id

      t.timestamps
    end
  end
end
