class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: %i[ show edit update destroy ]
  before_action :set_links, only: %i[ index create update ]

  def index
  end

  def show
  end

  def new
    @link = Link.new
  end

  def edit
  end

  def create
    @link = Link.find_by(url: link_params[:url]) || current_user.links.build(link_params)
    respond_to do |format|
      if @link.save
        slice_params_for_pagination
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("converted-wrapper", partial: 'links/converted_url'),
            turbo_stream.update("table-links", partial: 'links/table_links', )
          ]
        end
      else
        format.html { redirect_to root_path, status: :unprocessable_entity, alert: @link.errors.full_messages.first }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to root_path, notice: 'Update link successful' }
      else
        format.html { redirect_to root_path, alert: @link.errors.full_messages.first }
      end
    end
  end

  def destroy
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url, notice: "Link was successfully destroyed." }
    end
  end

  private

  def set_link
    @link = current_user.links.find_by(id: params[:id])
  end

  def set_links
    @links = current_user.links.order(created_at: :desc).page(params[:page]).per(params[:per])
  end

  def link_params
    params.require(:link).permit(:url, :shorten_code)
  end

  def slice_params_for_pagination
    params.slice!(:page, :per)
  end
end
