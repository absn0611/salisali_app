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
                  params[:goods_name][i].to_s + "の在庫数" + @stocks[i].quantity_of_stock.to_s + "個"
                  )
              end
          end
      
          if 
              @alert != []
              flash[:notice] = "申し訳ありません。次の商品の在庫が不足しております、再度ご指定ください"
              flash[:notice2] = @alert
              render "stocks/index"
              return
              
          end
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
