class OrdersController < ApplicationController
    def index
        @orders = Order.all
    end

    def new
    end

    def create
        if params[:user_id]
            params[:user_id].count.times do |i|
            @order = Order.new(user_id:@current_user.id,goods_master_id:params[:goods_master_id][i],amount:params[:amount][i],delivery_date:Time.current.since(7.days))
            @order.save
        end
    else
        redirect_to root_path
    end

    end

    def edit
    end
end
