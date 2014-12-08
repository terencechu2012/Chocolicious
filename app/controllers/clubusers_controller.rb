class ClubusersController < ApplicationController
  before_action :set_clubuser, only: [:show, :edit, :update, :destroy]
  # GET /clubusers
  # GET /clubusers.json
  def index
    @clubusers = Clubusers.all
  end

  # GET /clubusers/1
  # GET /clubusers/1.json
  def show
  end

  # GET /clubusers/new
  def new
    @clubuser = Clubusers.new
  end
  
  def new2
    @clubuser = Clubusers.new
  end
  # GET /clubusers/1/edit
  def edit
  end

  # POST /clubusers/1
  # POST /clubusers.json
  def create
    @clubuser = Clubusers.new(clubuser_params)

    respond_to do |format|
      if @clubuser.save
        format.html { redirect_to @clubuser, notice: 'Clubuser was successfully created.' }
        format.json { render :show, status: :created, location: @clubuser }
      else
        format.html { render :new }
        format.json { render json: @clubuser.errors, status: :unprocessable_entity }
      end
    end
  end

  def create2
    @clubuser = Clubusers.new(clubuser_params)

    respond_to do |format|
      if @clubuser.save
        format.html { redirect_to @clubuser, notice: 'Clubuser was successfully created.' }
        format.json { render :show, status: :created, location: @clubuser }
      else
        format.html { render :new }
        format.json { render json: @clubuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clubusers/1
  # PATCH/PUT /clubusers/1.json
  def update
    respond_to do |format|
      if @clubuser.update(clubuser_params)
        format.html { redirect_to @clubuser, notice: 'Clubuser was successfully updated.' }
        format.json { render :show, status: :ok, location: @clubuser }
      else
        format.html { render :edit }
        format.json { render json: @clubuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubusers/1
  # DELETE /clubusers/1.json
  def destroy
    @clubuser.destroy
    respond_to do |format|
      format.html { redirect_to clubusers_url, notice: 'Clubuser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_clubuser
    @clubuser = Clubusers.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def clubuser_params
    params.require(:clubusers).permit(:userid, :clubid, :role)
  end
end
