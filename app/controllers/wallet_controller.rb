# frozen_string_literal: true

class WalletController < ApplicationController
  def show
    @wallet = current_user.wallet
  end

  def update
    @wallet = current_user.wallet

    current_balance = @wallet.balance
    new_balance = current_balance + wallet_params[:add_balance].to_d

    if wallet_params[:add_balance].to_d > 0 && @wallet.update(balance: new_balance)
      redirect_to(wallet_path, notice: "Your wallet has been charged")
    else
      flash.now[:alert] = "Unable to charge your wallet"
      render("show")
    end
  end

  private

  def wallet_params
    params.require(:wallet).permit(:add_balance)
  end
end
