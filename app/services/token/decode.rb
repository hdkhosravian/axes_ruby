module Token
  class Decode
    include Peafowl

    attribute :token, Hash
    attribute :leeway, Integer
    validates :token, presence: true

    def call
      iss = ENV["ISSUER"].to_s
      leeway ||= 30

      decoded = JWT.decode(token, secret_key, leeway: leeway, iss: iss, verify_iss: true, verify_iat: true)
      context[:decoded] = decoded
    end

    private
    def secret_key
      Rails.application.credentials.secret_key_base || ENV["SECRET_KEY"]
    end
  end
end
