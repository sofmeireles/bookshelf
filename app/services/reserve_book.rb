class ReserveBook
  Result = Struct.new(:success?, :reservation, :errors, :book, keyword_init: true)

  def initialize(book, user_id)
      @book = book
      @user_id = user_id
  end

  def perform
      reservation = Reservation.create!(book: book, user_id: user_id)
      send_new_reservation_email(reservation)

      Result.new( { success?: true, reservation: reservation} )
  rescue ActiveRecord::RecordInvalid => error
      Result.new( {success?: false, errors: error.record.errors.full_messages, book: book} )
  end

  private 

  attr_reader :book, :user_id

  def send_new_reservation_email(reservation)
    User.admin_users.each do |user|
     SendNewReservationEmailJob.perform_async(reservation.user_id, user.id, reservation.book_id)
    end
  end
end