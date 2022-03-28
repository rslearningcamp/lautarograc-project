module Api
  module V1
    class ApiController < ApplicationController
      include Api::Concerns::ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken
    end
  end
end
