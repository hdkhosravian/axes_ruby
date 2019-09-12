class AddExpireAtToAuthTokens < ActiveRecord::Migration[5.2]
  def change
    add_column :auth_tokens, :expire_at, :datetime
  end
end
