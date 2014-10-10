class UtilsController < ApplicationController
  # GET /utils/set
  def set
    r = params[:red].blank? ? "000" : params[:red]
    g = params[:green].blank? ? "000" : params[:green]
    b = params[:blue].blank? ? "000" : params[:blue]
    brightness = params[:brightness].blank? ? "32" : params[:brightness]
    Arduino::send_message("set#{r}#{g}#{b}#{brightness}")
    render text: "Woohoo"
  end
end
