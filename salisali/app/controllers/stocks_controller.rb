# coding: utf-8

class StocksController < ApplicationController
  def new
    @stocks = Stock.all
  end

  def index
    @stocks = Stock.all
  end

  def create

    if params[:new_goods]
      if params[:id] !="" and params[:goods_name] != "" and params[:price].to_i > 0
      
        render "goods_masters/new"
        return
      
        # render plain: params.inspect
      # redirect_to new_stock_path
      return
      else
        # redirect_to new_stock_path
        @stocks = Stock.all
        if params[:id] == ""
          flash.now[:notice] = "商品コードを指定してください"
        end

        if params[:goods_name] == ""
        flash.now[:notice2] = "商品名を指定してください"
        end

        if params[:price].to_i <= 0
          flash.now[:notice3] = "価格を０以上の値で指定してください"
        end
        
        render "stocks/new"
      end
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
