class ReservationAdapter < BaseAdapter

  set_attribute(:code) do |attribute|
    attribute.add_converter do |params|
      params[:reservation_code]
    end
    attribute.add_converter do |params|
      params[:reservation][:code]
    end
  end

  set_attribute(:number_of_guests) do |attribute|
    attribute.add_converter do |params|
      params[:guests]
    end
    attribute.add_converter do |params|
      params[:reservation][:number_of_guests]
    end
  end

  set_attribute(:status) do |attribute|
    attribute.add_converter do |params|
      params[:status]
    end
    attribute.add_converter do |params|
      params[:reservation][:status_type]
    end
  end

  set_attribute(:start_date) do |attribute|
    attribute.add_converter do |params|
      params[:start_date].to_date
    end
    attribute.add_converter do |params|
      params[:reservation][:start_date]
    end
  end
  set_attribute(:end_date) do |attribute|
    attribute.add_converter do |params|
      params[:end_date].to_date
    end
    attribute.add_converter do |params|
      params[:reservation][:end_date]
    end
  end
  set_attribute(:number_of_nights) do |attribute|
    attribute.add_converter do |params|
      params[:nights].to_i
    end
    attribute.add_converter do |params|
      params[:reservation][:nights]
    end
  end
  set_attribute(:number_of_adults) do |attribute|
    attribute.add_converter do |params|
      params[:adults].to_i
    end
    attribute.add_converter do |params|
      params[:reservation][:guest_details][:number_of_adults]
    end
  end
  set_attribute(:number_of_children) do |attribute|
    attribute.add_converter do |params|
      params[:children].to_i
    end
    attribute.add_converter do |params|
      params[:reservation][:guest_details][:number_of_children]
    end
  end
  set_attribute(:number_of_infants) do |attribute|
    attribute.add_converter do |params|
      params[:infants].to_i
    end
    attribute.add_converter do |params|
      params[:reservation][:guest_details][:number_of_infants]
    end
  end
  set_attribute(:currency) do |attribute|
    attribute.add_converter do |params|
      params[:currency]
    end
    attribute.add_converter do |params|
      params[:reservation][:host_currency]
    end
  end
  set_attribute(:payout_price) do |attribute|
    attribute.add_converter do |params|
      params[:payout_price]
    end
    attribute.add_converter do |params|
      params[:reservation][:expected_payout_amount]
    end
  end
  set_attribute(:security_price) do |attribute|
    attribute.add_converter do |params|
      params[:security_price]
    end
    attribute.add_converter do |params|
      params[:reservation][:listing_security_price_accurate]
    end
  end
  set_attribute(:total_price) do |attribute|
    attribute.add_converter do |params|
      params[:total_price]
    end
    attribute.add_converter do |params|
      params[:reservation][:total_paid_amount_accurate]
    end
  end
end