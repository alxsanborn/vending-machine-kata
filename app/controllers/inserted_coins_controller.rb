class InsertedCoinsController < ApplicationController
  def new
  end

  def create
  end

  def show
    @inserted_coin = InsertedCoin.find(params[:id])
  end
end
