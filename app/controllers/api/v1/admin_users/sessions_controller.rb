module Api
  module V1
    module AdminUsers
      class SessionsController < DeviseTokenAuth::SessionsController
        protect_from_forgery with: :exception
        include Api::Concerns::ActAsApiRequest

        private

        def resource_params
          params.require(:admin_user).permit(:email, :password)
        end

        def render_create_success
          render :show
        end
      end
    end
  end
end
