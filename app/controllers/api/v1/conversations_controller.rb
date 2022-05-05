module Api
  module V1
    class ConversationsController < Api::V1::ApiController
      def index
        @conversations = Match.from_user(current_api_user).map(&:conversation)
        render json: @conversations, status: :ok
      end
    end
  end
end
