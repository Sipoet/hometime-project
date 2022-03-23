class ReservationAdapter < BaseAdapter

  set_attribute(:code) do |params|
    params[:reservation_code] || params[:reservation][:code]
  end

  set_attribute(:number_of_guests) do |params|
    params[:guests] || params[:reservation][:number_of_guests]
  end

  set_attribute(:status) do |params|
    params[:status] || params[:reservation][:status_type]
  end
end