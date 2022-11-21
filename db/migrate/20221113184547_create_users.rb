class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false # THIS WAS ADDED BECAUSE EMAIL CANNOT BE NULL
      t.string :password_digest, null: false # THIS WAS ADDED BECAUSE EMAIL CANNOT BE NULL

      t.timestamps
    end
  end
end
