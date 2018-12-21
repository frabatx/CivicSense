class SolversController < ApplicationController
  before_action :authenticate_user!
  before_action :check_role
  before_action :set_solver, only: [:show, :edit, :update, :destroy]

  # GET /solvers
  # GET /solvers.json
  def index
    if current_user.superuser?
      @solvers = Solver.all
    else
      @solvers = current_user.administration.try(:solvers)
    end
  end

  # GET /solvers/1
  # GET /solvers/1.json
  def show
  end

  # GET /solvers/new
  def new
    @solver = Solver.new
    @solver.build_user
  end

  # GET /solvers/1/edit
  def edit
  end

  # POST /solvers
  # POST /solvers.json
  def create
    @solver = Solver.new(solver_params)
    @solver.user.role = 3

    if current_user.role == 2
      @solver.administration_id = current_user.administration.id
    end

    if @solver.save
      SolverMailer.with(solver: @solver, password: params[:solver][:user_attributes][:password]).welcome_email.deliver_now
      redirect_to @solver, notice: 'Solver was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /solvers/1
  # PATCH/PUT /solvers/1.json
  def update
    if @solver.update(solver_params)
      redirect_to @solver, notice: 'Solver was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /solvers/1
  # DELETE /solvers/1.json
  def destroy
    @solver.destroy
    redirect_to solvers_url, notice: 'Solver was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solver
      @solver = Solver.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solver_params
      params.require(:solver).permit(:name, :description, :phone_number, :administration_id, :user_attributes => [:email, :password])
    end
end
