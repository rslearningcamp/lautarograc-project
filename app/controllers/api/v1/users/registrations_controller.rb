module Api
  module V1
    module Users
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        protect_from_forgery with: :exception
        include Api::Concerns::ActAsApiRequest

        def sign_up_params
          params.require(:user).permit(:email, :password, :password_confirmation,
                                       :name)
        end

        def render_create_success
          render json: { user: resource_data }
        end
      end
    end
  end
end
