class ReservationsController < ApplicationController


  def create_or_update
    result = Reservation::CreateOrUpdateService.run(params)
    render_json result
  end
end
