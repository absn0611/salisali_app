class OrdersController < ApplicationController

    def index
        if params[:amount].map(&:to_i).sum == 0 or params[:amount].map(&:to_i).sum == nil
            @orders = params
            
            redirect_to root_path, notice: '注文する商品を指定してください' 
        end

    end
    
    def new
    end

    def create
        if  params[:amount]
            params[:goods_master_id].count.times do |i|
                if params[:amount][i] == 0 or params[:amount][i] == nil
                    redirect_to root_path, notice: '注文する商品を指定してください' 
 
                else

                    @order = Order.new(user_id:@current_user.id, goods_master_id:params[:goods_master_id][i], amount:params[:amount][i],delivery_date:Time.current.since(7.days))
                    # @order = Stock.create(goods_master_id:"J002-02",quantity_of_stock:"200")
                    # @order.save
                    # @stock = Order.Stock.update(goods_master_id:params[:goods_master_id][i], quantity_of_stock:15)
                    # redirect_to stock_path(@order.goods_master_id)
                    render plain: @order.stock.inspect
                    return
                end
                
            end

            # render plain: params.inspect

        # redirect_to root_path
    end

    end

    def edit
    end
end
