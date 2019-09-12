module API
  module V1
    class ApiController < ApplicationController
      rescue_from ActiveRecord::RecordInvalid, with: :database_error
      rescue_from ActiveRecord::RecordNotFound, with: :record_invalid_error
      rescue_from BadRequestError, with: :bad_request_error
      rescue_from NotFoundError, with: :not_found_error
      rescue_from JWT::DecodeError, with: :authentication_error
      rescue_from JWT::ExpiredSignature, with: :authentication_error
      rescue_from AuthorizationError, with: :authentication_error

      protected

      # authenticate user from Authorization in header with exception
      def authenticate_user_from_token!
        raise AuthorizationError unless http_auth_token.present?
        result = find_user
        raise BadRequestError, result.errors if result.failure?
        @current_user = result.current_user
      end

      # we use this method for pundit
      def current_user
        @current_user
      end

      private

      def find_user
        result = Authentications::Authenticate.call(auth_token: http_auth_token)
      end

      # get token from Authorization in header
      def http_auth_token
        auth_token = request.env["HTTP_AUTHORIZATION"]
        auth_token.split(" ").last if auth_token.present? && auth_token.split(" ").first.downcase == "bearer"
      end

      private

      def bad_request_error(exception)
        render json: { response: JSON.parse(exception.message), status: 400 }.to_json, status: 400
      end

      def database_error(exception)
        exception = [exception.message]
        render json: { response: exception, status: 400 }.to_json, status: 400
      end

      def record_invalid_error(exception)
        exception = [exception.message]
        render json: { response: exception, status: 404 }.to_json, status: 404
      end

      def authentication_error
        render json: { response: [I18n.t("messages.http._401")], status: 401 }.to_json, status: 401
      end

      def not_found_error(exception)
        render json: { response: JSON.parse(exception.message), status: 404 }.to_json, status: 404
      end
    end
  end
end