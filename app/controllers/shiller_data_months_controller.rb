class ShillerDataMonthsController < ApplicationController
  def cape_data
    result = ShillerDataMonth.cape_data_array
    respond_to do |format|
      format.json { render json: "callback(#{result});"}
    end
  end
end
