module Api
  module V1
    class TargetsController < Api::V1::ApiController
      before_action :set_target, only: [:destroy]
      def create
        @target = Target.new(target_params.merge(user_id: current_api_user.id))
        if @target.save
          expirate
          render :create, status: :created
        else
          render json: { errors: @target.errors }, status: :unprocessable_entity
        end
      end

      def index
        @targets = Target.where(user_id: current_api_user.id).all
        render :index, status: :ok
      end

      def destroy
        @target.destroy!
        head :no_content
      end

      private

      def target_params
        params.require(:target).permit(:latitude, :longitude, :title, :radius, :topic_id)
      end

      def set_target
        @target = Target.find(params[:id])
        head :forbidden if current_api_user.id != @target.user_id
      end

      def expirate
        TargetExpirationJob.perform_in(7.days, @target.id)
      end
    end
  end
end
