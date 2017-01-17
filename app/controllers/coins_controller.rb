class CoinsController < ApplicationController
  def new
  end

  def create
  end

  def show
    @coin = Coin.find(params[:id])
  end
end
