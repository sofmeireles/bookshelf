class ReturnBook
  Result = Struct.new(:success?, :reservation, :errors, :book, keyword_init: true)

  def initialize(reservation)
    @reservation = reservation
  end

  def perform
    reservation.update!(returned_on: Date.today)
    send_returned_book_email(reservation)

    Result.new( { success?: true, reservation: reservation} )
  rescue ActiveRecord::RecordInvalid => error
      Result.new( {success?: false, errors: error.record.errors.full_messages } )
  end

  private

  attr_accessor :reservation

  def send_returned_book_email(reservation)
    User.admin_users.each do |user|
      SendReturnedBookEmailJob.perform_async(reservation.user_id, user.id, reservation.book_id)
    end
  end

end