class CompanyReservationsController < ApplicationController
  before_action :set_company_reservations

  def index; end

  private

  def set_company_reservations
    @company_reservations = Reservation.includes(:user, :book)
                                        .active
                                        .where.not(user: current_user)
  end

end