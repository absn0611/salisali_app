class OrdersController < ApplicationController
    def index
        @orders = Order.all
    end

    def new
    end

    def create
        if  params[:amount]
            params[:user_id].count.times do |i|
                if params[:amount][i] == 0 or params[:amount][i] == nil
                      render plain: params.inspect

                else

                    @order = Order.new(user_id:@current_user.id, goods_master_id:params[:goods_master_id][i], amount:params[:amount][i],delivery_date:Time.current.since(7.days))
                    @order.save
                end
            end
        # redirect_to root_path
    end

    end

    def edit
    end
end
