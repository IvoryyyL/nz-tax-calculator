class CalculationsController < ApplicationController
  def new
    @calculation = Calculation.new
  end

  def create
    @calculation = Calculation.new(params.require(:calculation).permit(:income))

    if @calculation.valid?
      @result = Calculator.call(@calculation.income)
      render :new
    else
      render :new, status: :unprocessable_entity
    end
  end
end
