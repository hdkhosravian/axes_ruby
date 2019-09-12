module API
  module V1
    class AuthenticationsController < ApiController
      before_action :authenticate_user_from_token!, only: [:logout]

      def sign_up
        result = Authentications::SignUp.call(params.permit(
            :email,
            :password,
            :confirm_password
        ))
        raise BadRequestError, result.errors if result.failure?

        sign_in_user
      end

      def sign_in
        sign_in_user
      end

      def logout
        @current_user.token.update(expire_at: 1.days.ago)
      end

      private

      def sign_in_user
        result = Authentications::SignIn.call(params.permit(
          :email,
          :password
        ))
        raise BadRequestError, result.errors if result.failure?

        @user = result.user
        @user.reload

        render "api/v1/users/show", status: :ok
      end
    end
  end
end
