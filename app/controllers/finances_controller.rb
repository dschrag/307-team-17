class FinancesController < ApplicationController

  def new
    @finances = Finance.new
  end

end
