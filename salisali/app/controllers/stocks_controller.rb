# coding: utf-8

class StocksController < ApplicationController
  def new
    @stocks = Stock.all
  end

  def show
      @stocks = Stock.all
      # render plain: params.inspect
  end

  def create

      if params[:amount].map(&:to_i).sum == 0 or params[:amount].map(&:to_i).sum == nil
        @stocks = Stock.all

        render 'new'

        # redirect_to root_path

        # render plain: params.inspect
      else
        render 'show'
      end
    # end
      # end
  end

end
