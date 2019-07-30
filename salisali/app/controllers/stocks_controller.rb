# coding: utf-8

class StocksController < ApplicationController
  def new
    @stocks = Stock.all
  end
end
