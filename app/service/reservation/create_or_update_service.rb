class Reservation::CreateOrUpdateService < BaseService


  def call(params)
    check_guest(params)
    check_reservation(params)
    @result.success!
    @result.data = {message: 'success'}
  rescue ValidationError => e
    Rails.logger.warn("error: #{e.message}")
  end

  private

  def check_reservation(params)
    adapter = ReservationAdapter.new(params)
    reservation_data = adapter.convert
    Rails.logger.debug" Reservation Converted result: #{reservation_data.inspect}"
    reservation = Reservation.find_or_initialize_by(code: reservation_data[:code])
    reservation.attributes = reservation_data
    if !reservation.save
      reservation.error.full_messages.each do |message|
        add_error(title: 'reservation save failed', message: message)
      end
      raise ValidationError.new('reservation save failed')
    end
  end

  def check_guest(params)
    adapter = GuestAdapter.new(params)
    guest_data = adapter.convert
    Rails.logger.debug" Guest Converted result: #{guest_data.inspect}"
    guest = Guest.find_or_initialize_by(email: guest_data[:email])
    guest.attributes = guest_data
    if !guest.save
      guest.error.full_messages.each do |message|
        add_error(title: 'guest save failed', message: message)
      end
      raise ValidationError.new('guest save failed')
    end
  end
end