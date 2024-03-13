class UserMailer < ApplicationMailer
  before_action :set_recipient
  before_action :set_reservation

  default to: -> { @recipient.email }

  def reading_progress
    mail(subject: "Reading progess on #{@reservation.book.title}")
  end


  private

  def set_reserver
    @recipient = params[:reserver]
  end

  def set_reservation
    @reservation = params[:reservation]
  end
end