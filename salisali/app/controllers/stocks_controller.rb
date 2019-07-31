# coding: utf-8

class StocksController < ApplicationController
  def new
    @stocks = Stock.all
    @order_hoge = Order.new
  end


end
