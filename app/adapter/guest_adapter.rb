class GuestAdapter < BaseAdapter

  set_attribute(:email) do |params|
    if params[:guest].present?
      params[:guest][:email]
    elsif params[:reservation]
      params[:reservation][:guest_email]
    end
  end

  set_attribute(:first_name) do |params|
    if params[:guest].present?
      params[:guest][:first_name]
    elsif params[:reservation]
      params[:reservation][:guest_first_name]
    end
  end

  set_attribute(:last_name) do |params|
    if params[:guest].present?
      params[:guest][:last_name]
    elsif params[:reservation]
      params[:reservation][:guest_last_name]
    end
  end
end