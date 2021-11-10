# frozen_string_literal: true

class UserTicketsController < ApplicationController
  # GET /tickets
  def index
    @tickets =
      current_user.tickets
        .includes([trip: [:departure_point, :destination_point]])
        .order("created_at DESC")
        .page(params[:page])
  end

  # DELETE /tickets/1
  def destroy
    ticket = Ticket.find(params[:id])

    success = false
    if ticket.future_trip?
      ActiveRecord::Base.transaction do
        ticket.refund_user
        success = ticket.destroy
      end
    end

    if success
      logger.info(t("logger.info.destroy", record_type: ticket.model_name.human, id: ticket.id))
      redirect_to(user_tickets_path, notice: t("notice.cancel_trip"))
    else
      logger.info(t("error.info.destroy", record_type: ticket.model_name.human, id: ticket.id))
      redirect_to(user_tickets_path, alert: t("alert.cancel_trip"))
    end
  end
end
