class CountingsController < ApplicationController
  before_action :authentication!

  def index
    @countings = current_user.countings
  end

  def show
    days = (Date.today - set_counting.duration).upto(Date.today).to_a
    @rates = RateHistory.where(date: days).order(date: :desc)
    set_counting
  end

  def new
    @counting = Counting.new
  end

  def edit
    set_counting
  end

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

  def destroy
    set_counting.destroy
    respond_to do |format|
      format.html { redirect_to countings_url, notice: 'Counting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_counting
    @counting ||= current_user.countings.find(params[:id])
  end

  def counting_params
    params.require(:counting).permit(
      :basic_currency,
      :target_currency,
      :amount,
      :duration
  )
  end
end
