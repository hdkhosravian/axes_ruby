module API
  module V1
    class ProfilesController < ApiController
      before_action :authenticate_user_from_token!
      before_action :profile

      def show
        render "api/v1/profile/show", status: :ok
      end

      def update
        update_profile!
        render "api/v1/profile/show", status: :ok
      end

      def change_password
        result = Profiles::ChangePassword.call(params.permit(
          :old_password,
          :password,
          :confirm_password
        ).merge(user: @current_user))

        raise BadRequestError, result.errors if result.failure?

        render json: { response: "OK" }, status: :ok
      end

      def change_keywords
        result = Profiles::ChangeKeywords.call(
          user_keywords: params[:keywords].downcase,
          profile: @profile
        )

        raise BadRequestError, result.errors if result.failure?

        render "api/v1/profile/show", status: :ok
      end

      def keywords
        @client_keywords = @current_user.profile.keywords.map(&:key)
        render json: {keywords: @client_keywords}, status: 200
      end

      def upload_avatar
        Image.create(picture: params[:avatar], imageable: @current_user.profile)

        render "api/v1/profile/show", status: 201
      end
      
      private

      def profile
        @profile = @current_user.profile
      end

      def update_profile!
        @profile.first_name = params[:first_name] if params[:first_name].present?
        @profile.last_name = params[:last_name] if params[:last_name].present?
        @profile.country = params[:country] if params[:country].present?
        @profile.state = params[:state] if params[:state].present?
        @profile.city = params[:city] if params[:city].present?
        @profile.postal_code = params[:postal_code] if params[:postal_code].present?
        @profile.address = params[:address] if params[:address].present?
        @profile.phone_number = params[:phone_number] if params[:phone_number].present?
        @profile.user_description = params[:user_description] if params[:user_description].present?

        @profile.save!
        @profile.reload
      end
    end
  end
end
