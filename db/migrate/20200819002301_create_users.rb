class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
    
      t.string :email
      t.string :username
      t.string :name
      t.string :uid
      t.string :image
      t.string :password_digest

      t.timestamps
    end
  end
end
