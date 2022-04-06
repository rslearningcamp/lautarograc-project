module Api
  module V1
    class ApiController < ApplicationController
      include Api::Concerns::ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_api_user!
    end
  end
end
