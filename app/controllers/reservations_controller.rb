class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservations, only: [:index]
  before_action :set_active_reservation, only: [:show, :update]

  def index; end

  def edit; end

  def show; end

  def update 
      result = ReturnBook.new(@active_reservation).perform

      if result.success?
        respond_to do |format|
          format.turbo_stream
          flash.now[:notice] = I18n.t('notices.books.return_success', book_title: @active_reservation.book.title)
        end
      else
          flash.now[:alert] = result.errors
          render :reservations, status: :unprocessable_entity
      end
  end

  private

  def set_reservations
    @reservations = current_user.reservations.includes(:book).order(created_at: :desc)
  end

  def set_active_reservation
    @active_reservation = Reservation.find_by!(user: current_user, returned_on: nil)
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end