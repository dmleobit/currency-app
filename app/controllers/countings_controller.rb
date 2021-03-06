class CountingsController < ApplicationController
  before_action :authentication!
  before_action :set_counting, only: %i(show edit update destroy)

  def index
    @countings = current_user.countings
  end

  def show
    @facade = CollectDataForShow.new(@counting)
  end

  def new
    @counting = Counting.new
  end

  def create
    @counting = current_user.countings.new(counting_params)
    return render :new unless @counting.save

    redirect_to @counting, notice: "Counting was successfully created."
  end

  def update
    return render :edit unless @counting.update(counting_params)

    redirect_to @counting, notice: "Counting was successfully updated."
  end

  def destroy
    @counting.destroy
    redirect_to countings_url, notice: "Counting was successfully destroyed."
  end

  private

  def set_counting
    @counting = current_user.countings.find(params[:id])
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
