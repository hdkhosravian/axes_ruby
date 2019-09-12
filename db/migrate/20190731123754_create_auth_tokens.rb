class CreateAuthTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :auth_tokens, id: :uuid do |t|
      t.string :token
      t.references :user, type: :uuid, foreign_key: true

      t.timestamps
    end

    add_index :auth_tokens, :token, unique: true
  end
end
