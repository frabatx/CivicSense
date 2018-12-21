class ScreamsController < ApplicationController
  before_action :authenticate_user!, except: [:create, :new, :show]
  before_action :set_scream, only: [:show, :edit, :update, :destroy]
  before_action :is_mobile?, only: [:new]


  # GET /screams
  # GET /screams.json
  def index
    if current_user.superuser?
      @screams = Scream.all
    elsif current_user.administration?
      @screams = current_user.administration.try(:screams)
    elsif current_user.solver?
      @screams = current_user.solver.try(:screams)
    end

    @screams = @screams.with_status(session[:status_filter]) if session[:status_filter]
    @screams = @screams.from_date(session[:date_start_filter]) if session[:date_start_filter]
    @screams = @screams.to_date(session[:date_start_filter]) if session[:date_start_end]
    
    respond_to do |format|
      format.html
      format.json { render :json => @screams.to_json }
    end
  end

  def set_filter
    session[:status_filter] = filter_params[:status]
    session[:date_start_filter] = filter_params[:date_start]
    session[:date_end_filter] = filter_params[:date_end]
    redirect_to screams_path
  end

  # GET /screams/1
  # GET /screams/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @scream }
    end
  end

  # GET /screams/new
  def new
    @scream = Scream.new
  end

  # GET /screams/1/edit
  def edit
  end

  # POST /screams
  # POST /screams.json
  def create
    @scream = Scream.new(scream_params)

    if @scream.save
      ScreamerMailer.with(scream: @scream).created.deliver_now if @scream.screamer_email
      render :thanks
    else
      render :new
    end
  end

  # PATCH/PUT /screams/1
  # PATCH/PUT /screams/1.json
  def update
    if @scream.update(scream_update_params)
      ScreamerMailer.with(scream: @scream).updated.deliver_now if @scream.screamer_email
      redirect_to @scream, notice: 'Scream was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /screams/1
  # DELETE /screams/1.json
  def destroy
    @scream.destroy
    respond_to do |format|
      format.html { redirect_to screams_url, notice: 'Scream was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scream
      @scream = Scream.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scream_params
      params.require(:scream).permit(:latitude, :longitude, :address, :description, :priority, :screamer_email, :category_id, :administration_id, :solver_id, uploads: [])
    end

    def scream_update_params
      params.require(:scream).permit(:address, :status, :description, :priority, :screamer_email, :category_id, :administration_id, :solver_id)
    end

    def filter_params
      params.require(:filter).permit(:status, :date_start, :date_end)
    end

    def is_mobile?
      unless browser.device.mobile?
        render :mobile_only
      end
    end
end
