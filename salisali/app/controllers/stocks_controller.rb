# coding: utf-8

class StocksController < ApplicationController
  def new
    @stocks = Stock.all
  end

  def show
    # render plain: params.inspect

    @stock = Stock.all
  end

  def update
    # render plain: params.inspect
  end

  

end
