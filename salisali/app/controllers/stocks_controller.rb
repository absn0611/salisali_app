# coding: utf-8

class StocksController < ApplicationController

  def new

    admin_login
    @goods_master = GoodsMaster.new
    @stocks = Stock.all


  end

  def index

    @stocks = Stock.all
    @orders = Order.where(user_id:@current_user.id)

    @order_sum = 0
    @orders.count.times do |i|
    @goods_master = GoodsMaster.find(@orders[i][:goods_master_id])
    @order_sum += @goods_master[:price] * @orders[i][:amount]
      
    end

  end


  def create
    
    admin_login

    # render plain: params.inspect
    # return
    @goods_master = GoodsMaster.new

    if params[:goods_master][:new_goods]
      if params[:goods_master][:id] !="" and params[:goods_master][:goods_name] != "" and params[:goods_master][:price].to_i > 0 and GoodsMaster.find_by(id: params[:goods_master][:id]) == nil and GoodsMaster.find_by(goods_name: params[:goods_master][:goods_name]) == nil
      
        render "goods_masters/new"
        return
      else
        @stocks = Stock.all

        if GoodsMaster.find_by(id: params[:goods_master][:id])

          flash.now[:notice] = params[:goods_master][:id] + "は既に登録されているため登録できません。"
        else
          flash.now[:notice] = ""
        end

        if GoodsMaster.find_by(goods_name: params[:goods_master][:goods_name])

          flash.now[:notice2] = params[:goods_master][:goods_name] + "は既に登録されているため登録できません。"
          
        end

        if params[:goods_master][:id] == ""
          flash.now[:notice] = "商品コードを指定してください"
        end

        if params[:goods_master][:goods_name] == ""
        flash.now[:notice2] = "商品名を指定してください"
        end

        if params[:goods_master][:price].to_i <= 0
          flash.now[:notice3] = "価格を０以上の値で指定してください"
        end
        
        render "stocks/new"
      end
    else
      # render plain: params[:goods_master][:goods_name].inspect
      # return
      params[:goods_master][:goods_master_id].count.times do |i| 
        if params[:goods_master][:amount][i] == ""
        else
        @stock = Stock.find(params[:goods_master][:goods_master_id][i])
            @order = Stock.where(goods_master_id:params[:goods_master][:goods_master_id][i]).update(
                goods_master_id:params[:goods_master][:goods_master_id][i],
                quantity_of_stock:(@stock.quantity_of_stock + params[:goods_master][:amount][i].to_i)
                )
        end
      end
      redirect_to new_stock_path
    end
    
  end

  def admin_login
    if @current_user and @current_user.admin == "true"
    else
      redirect_to root_path
    end
  end

end
