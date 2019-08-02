# coding: utf-8

class StocksController < ApplicationController
  def new
    @stocks = Stock.all
  end

  def index
    @stocks = Stock.all
  end

  def create

    if params[:new]
      render plain: params.inspect
      # redirect_to new_stock_path
    else
      params[:goods_master_id].count.times do |i| 
        if params[:amount][i] == ""
        else
        @stock = Stock.find(params[:goods_master_id][i])
            @order = Stock.where(goods_master_id:params[:goods_master_id][i]).update(
                goods_master_id:params[:goods_master_id][i],
                quantity_of_stock:(@stock.quantity_of_stock + params[:amount][i].to_i)
                )
        end
      end
      redirect_to new_stock_path
    end
    
  end
end
