module Api
  module V1
    class MessagesController < Api::V1::ApiController
      before_action :set_conversation
      def create
        @message = set_match.conversation.messages.new(message_params.merge(user: current_api_user))
        if @message.save
          render :create, status: :created
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      def index
        @messages = @conversation.messages.page(page).per(per_page)
        render :index, status: :ok
      end

      private

      def set_conversation
        @conversation = Conversation.find(params[:conversation_id])
        match_conversation = @conversation.match
        unless match_conversation.origin_target.user == current_api_user ||
               match_conversation.end_target.user == current_api_user
          @conversation = nil
        end
        head :forbidden unless @conversation
      end

      def set_match
        Match.from_user(current_api_user).where(@conversation_id).first
      end

      def message_params
        params.require(:message).permit(:title, :content)
      end

      def page
        params[:page] || ENV.fetch('PAGE', nil)
      end

      def per_page
        params[:per_page] || ENV.fetch('PER_PAGE', nil)
      end
    end
  end
end
