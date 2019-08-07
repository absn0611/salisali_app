class OrdersController < ApplicationController

    def new
        if params[:amount].map(&:to_i).sum == 0 or params[:amount].map(&:to_i).sum == nil

            redirect_to root_path, notice: '注文する商品を指定してください' 
            return
          end
      
          @stocks = Stock.all
          @alert = []
          params[:goods_name].count.times do |i| 
              
              if params[:amount][i].to_i > @stocks[i].quantity_of_stock
                  @alert.push(
                  params[:goods_name][i].to_s + "の在庫数は" + @stocks[i].quantity_of_stock.to_s + "個です"
                  )
              end
            #   render plain: @stocks[i].quantity_of_stock.to_s.inspect
            #   return

          end
      
          if 
              @alert != []
              flash.now[:notice] = "申し訳ありません。次の商品の在庫が不足しております、再度ご指定ください"
              flash.now[:notice2] = @alert
              @orders = Order.where(user_id:@current_user.id)
              render "stocks/index"
              return
              
          end

          @delivery_c = delivery_c

    end
          
    def create
            
        params[:goods_master_id].count.times do |i| 
            @stock = Stock.find(params[:goods_master_id][i])
                @order = Stock.where(goods_master_id:params[:goods_master_id][i]).update(
                    goods_master_id:params[:goods_master_id][i],
                    quantity_of_stock:(@stock.quantity_of_stock - params[:amount][i].to_i)
                    )
                # # redirect_to stock_path(@order.goods_master_id)
    
            end

            params[:goods_master_id].count.times do |i| 
                @order = Order.new(
                    user_id:@current_user.id, 
                    goods_master_id:params[:goods_master_id][i], 
                    amount:params[:amount][i],
                    delivery_date:Time.current.since(delivery_c)
                    )
                    
                @order.save

            end

            redirect_to root_path
            
    end

    def edit
        @order = Order.find(params[:id])
        @delivery_c = delivery_c
    end

    def destroy
        @orders = Order.where(id:params[:id]).all
        @orders.each do |order|
            @stock = Stock.where(goods_master_id:order.goods_master_id)

        @stock = Stock.where(goods_master_id:order.goods_master_id).update(quantity_of_stock:(@stock[0].quantity_of_stock.to_i + order.amount.to_i))

        @order = Order.find(params[:id])
        @order.destroy
        redirect_to root_path
        end

    end

    def update
        @stock = Stock.find(params[:order][:goods_master_id])
        if params[:order][:amount].to_i > @stock.quantity_of_stock.to_i

            flash.now[:notice] = "申し訳ありません。以下の通り在庫が不足しております、再度ご指定ください"
            flash.now[:notice2] = "この商品の在庫数は" + @stock.quantity_of_stock.to_s + "個です"

            @order = Order.find(params[:id])
            @delivery_c = delivery_c
    
            render "orders/edit"
            return

        end
        @order = Order.find(params[:id])

        @order = Order.where(id:params[:order][:id]).update(amount:@order.amount.to_i + params[:order][:amount].to_i,delivery_date: Date.today + delivery_c)
        @stock = Stock.where(goods_master_id:params[:order][:goods_master_id]).update(quantity_of_stock:@stock.quantity_of_stock.to_i - params[:order][:amount].to_i)
        # render plain: 
        # @order.amount.inspect
        redirect_to root_path



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

    def order_params
        params.require(:order).permit(:id,:goods_master_id,:amount,:delivery_date)
    end
end
