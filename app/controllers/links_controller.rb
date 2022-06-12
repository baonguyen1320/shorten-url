class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @links = Link.order(created_at: :desc)
  end

  # GET /links/1 or /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links or /links.json
  def create
    @link = Link.find_by(url: link_params[:url]) || current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("converted-wrapper", partial: 'links/converted_url', locals: { link: @link.reload })
        end
        format.json { render :show, status: :created, location: @link }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity, alert: @link.errors.full_messages.first }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to root_path, notice: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity, alert: @link.errors.full_messages.first }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url, notice: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:url, :shorten_code)
    end
end
