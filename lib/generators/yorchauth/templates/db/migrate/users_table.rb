class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :token_id
      t.string :password_digest
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
