# frozen_string_literal: true

class UserTicketsController < ApplicationController
  # GET /tickets
  def index
    @tickets = current_user.tickets.includes([:trip]).order("created_at DESC").page(params[:page])
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
      redirect_to(user_tickets_path,
        notice: "The ticket has been canceled and the money will be refunded to your wallet.")
    else
      redirect_to(user_tickets_path, alert: "It was not possible to cancel the ticket.")
    end
  end
end
