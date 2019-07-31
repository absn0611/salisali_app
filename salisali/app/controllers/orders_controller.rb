class OrdersController < ApplicationController

    def index
        if params[:amount].map(&:to_i).sum == 0 or params[:amount].map(&:to_i).sum == nil
            @orders = params
            
            redirect_to root_path, notice: '注文する商品を指定してください' 
        end

    end
    
    def create

        if params[:amount].sum == 0 or params[:amount].sum == nil
            redirect_to root_path, notice: '注文する商品を指定してください' 
        else
            params[:goods_master_id].count.times do |i| 
                @order = Order.new(
                    user_id:@current_user.id, 
                    goods_master_id:params[:goods_master_id][i], 
                    amount:params[:amount][i],
                    delivery_date:Time.current.since(delivery_c)
                    )
                    
                @order.save

                # @user = User.find(@current_user.id)
                # render plain: 
                # # @current_user.area_master_id
                # # @current_user
                # @order.inspect
                # @user.area_master.distance_from_store
                # .inspect
                # return
        end

        params[:goods_master_id].count.times do |i| 
            @stock = Stock.find(params[:goods_master_id][i])
                @order = Stock.where(goods_master_id:params[:goods_master_id][i]).update(
                    goods_master_id:params[:goods_master_id][i],
                    quantity_of_stock:(@stock.quantity_of_stock - params[:amount][i].to_i)
                    )
                # # redirect_to stock_path(@order.goods_master_id)
    
            end
                
        end

    end

    private

    def delivery_c
        @user = User.find(@current_user.id)

        if @user.area_master.distance_from_store <= 50
            1.day
        else
            if @user.area_master.distance_from_store > 50 and @user.area_master.distance_from_store <= 200
                2.days
            else
                if @user.area_master.distance_from_store > 200
                    7.days        
                end
            end
        end
    end

end
