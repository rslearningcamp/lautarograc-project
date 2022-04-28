module Api
  module V1
    class ConversationsController < Api::V1::ApiController
      def index
        @conversations = Match.where("end_user_id = '#{current_api_user.id}'
            or origin_user_id = '#{current_api_user.id}'").map(&:conversation)
        render json: @conversations, status: :ok
      end
    end
  end
end
