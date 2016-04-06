class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :uid
      t.string :oauth_token
      t.string :oauth_token_expires
      t.string :image
      t.string :location

      t.timestamps null: false
    end
  end
end
