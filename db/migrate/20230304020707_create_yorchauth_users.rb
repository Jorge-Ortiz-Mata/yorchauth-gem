class CreateYorchauthUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :yorchauth_users do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
