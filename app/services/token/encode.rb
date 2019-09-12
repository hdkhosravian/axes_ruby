module Token
  class Encode
    include Peafowl

    attribute :payload, Hash
    validates :payload, presence: true

    def call
      token = JWT.encode(payload, secret_key)
      context[:token] = token
    end

    private

    def secret_key
      Rails.application.credentials.secret_key_base || ENV["SECRET_KEY"]
    end
  end
end
