class SendProgressEmailJob
  include Sidekiq::Job 
  sidekiq_options queue: 'low'

  def perform(reservation_id)
    reservation = Reservation.find(reservation_id)
    UserMailer.with(recipient: reservation.user, reservation: reservation)
              .reading_progress
              .deliver_now
  end


end