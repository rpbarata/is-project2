# frozen_string_literal: true

class WalletController < ApplicationController
  before_action :set_wallet

  def show; end

  def update
    if wallet_params[:add_balance].to_d <= 0
      flash.now[:alert] = "You must charge your wallet with a positive value"
      logger.info(t("logger.error.charge_wallet", user_id: current_user.id))
      render("show")
    elsif @wallet.deposit(wallet_params[:add_balance])
      logger.info(t("logger.info.charge_wallet", user_id: current_user.id))
      redirect_to(wallet_path, notice: t("notice.charge_wallet"))
    else
      flash.now[:alert] = t("alert.charge_wallet")
      logger.info(t("logger.error.charge_wallet", user_id: current_user.id))
      render("show")
    end
  end

  private

  def wallet_params
    params.require(:wallet).permit(:add_balance)
  end

  def set_wallet
    @wallet = current_user.wallet
  end
end
