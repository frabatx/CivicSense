class AdministrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_administration, only: [:show, :edit, :update, :destroy]
  before_action :check_role

  # GET /administrations
  def index
    @administrations = Administration.all
  end

  # GET /administrations/1
  def show
  end

  # GET /administrations/new
  def new
    @administration = Administration.new
    @administration.build_user
  end

  # GET /administrations/1/edit
  def edit
  end

  # POST /administrations
  def create
    @administration = Administration.new(administration_params)
    @administration.user.role = 2

    if @administration.save
      AdministrationMailer.with(administration: @administration, password: params[:administration][:user_attributes][:password]).welcome_email.deliver_now
      redirect_to @administration, notice: 'Administration was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /administrations/1
  def update
    if @administration.update(administration_params)
      redirect_to @administration, notice: 'Administration was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /administrations/1
  def destroy
    @administration.destroy
    redirect_to administrations_url, notice: 'Administration was successfully destroyed.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administration
      @administration = Administration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administration_params
      params.require(:administration).permit(:name, :phone_number, :city, :province, :street, :user_attributes => [:email, :password])
    end
end
