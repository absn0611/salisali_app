# coding: utf-8

class StocksController < ApplicationController
  def new
    @stocks = Stock.all
  end

  def index
    @stocks = Stock.all
  end

  def create
  end
end
