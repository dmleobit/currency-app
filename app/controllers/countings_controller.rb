class CountingsController < ApplicationController
  # before_action :set_counting, only: [:show, :edit, :update, :destroy]
  before_action :authentication!

  # GET /countings
  # GET /countings.json
  def index
    @countings = current_user.countings
  end

  # GET /countings/1
  # GET /countings/1.json
  def show
    set_counting
  end

  # GET /countings/new
  def new
    @counting = Counting.new
  end

  # GET /countings/1/edit
  def edit
    set_counting
  end

  # POST /countings
  # POST /countings.json
  def create
    @counting = current_user.countings.new(counting_params)

    respond_to do |format|
      if @counting.save
        format.html { redirect_to @counting, notice: 'Counting was successfully created.' }
        format.json { render :show, status: :created, location: @counting }
      else
        format.html { render :new }
        format.json { render json: @counting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /countings/1
  # PATCH/PUT /countings/1.json
  def update
    respond_to do |format|
      if set_counting.update(counting_params)
        format.html { redirect_to @counting, notice: 'Counting was successfully updated.' }
        format.json { render :show, status: :ok, location: @counting }
      else
        format.html { render :edit }
        format.json { render json: @counting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countings/1
  # DELETE /countings/1.json
  def destroy
    set_counting.destroy
    respond_to do |format|
      format.html { redirect_to countings_url, notice: 'Counting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_counting
      @counting ||= current_user.countings.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def counting_params
      params.require(:counting).permit(:basic_currency, :target_currency, :amount)
    end
end
