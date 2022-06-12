module Api::V1
  class LinksController < ApiController
    def index
      links = @current_user.links.order(created_at: :desc).page(params[:page]).per(params[:per])
      render json: {
        status: :ok,
        message: 'success',
        data: links
      }
    end

    def create
      link = @current_user.links.build(params.require(:link).permit(:url))
      if link.save
        render json: {
          status: :ok,
          message: 'success',
          data: link
        }
      else
        render json: {
          status: :unprocessable_entity,
          message: link.errors.full_messages,
        }
      end
    end

    def update
      link = @current_user.links.find_by(id: params[:id])
      if link&.update(params.require(:link).permit(:url, :shorten_url))
        render json: {
          status: :ok,
          message: 'success',
          data: link
        }
      else
        render json: {
          status: :unprocessable_entity,
          message: link&.errors&.full_messages || 'Incorrect data',
        }
      end
    end

    def destroy
      link = @current_user.links.find_by(id: params[:id])
      if link&.destroy
        render json: {
          status: :ok,
          message: 'success',
          data: link
        }
      else
        render json: {
          status: :unprocessable_entity,
          message: link&.errors&.full_messages || 'Incorrect data'
        }
      end
    end
  end
end
