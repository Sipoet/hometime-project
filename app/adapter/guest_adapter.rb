class GuestAdapter < BaseAdapter

  set_attribute(:email) do |attribute|
    attribute.add_converter do |params|
      params[:guest][:email]
    end
    attribute.add_converter do |params|
      params[:reservation][:guest_email]
    end
  end

  set_attribute(:first_name) do |attribute|
    attribute.add_converter do |params|
      params[:guest][:first_name]
    end
    attribute.add_converter do |params|
      params[:reservation][:guest_first_name]
    end
  end

  set_attribute(:last_name) do |attribute|
    attribute.add_converter do |params|
      params[:guest][:last_name]
    end
    attribute.add_converter do |params|
      params[:reservation][:guest_last_name]
    end
  end
end