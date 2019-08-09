class GoodsMastersController < ApplicationController
    
    def new
        admin_login
    end

    def create
        admin_login
        
        @goods_master = GoodsMaster.create(
            id: params[:id],
            goods_name: params[:goods_name],
            price: params[:price],
            about: params[:about],
            )

        @stock = Stock.create(
            goods_master_id: params[:id],
            quantity_of_stock: params[:quantity_of_stock].to_i
        )
        
        redirect_to new_stock_path
    end

    def destroy
        admin_login
        @order = Order.where(goods_master_id:params[:id]).any?
        
        if @order == true
            redirect_to edit_goods_master_path,notice: params[:id] + "は既にオーダーに登録があるため削除できません"
        else
            @goods_master = GoodsMaster.find(params[:id])
            @goods_master.destroy
            redirect_to new_stock_path,notice:params[:id] + "を商品マスタと在庫マスタから削除しました"
        end
    end

    def edit
        admin_login
        @goods_master = GoodsMaster.find(params[:id])
    end

    def update
        admin_login
        @goods_master = GoodsMaster.where(id: params[:id]).update(goodsmaster_params)
        
        @stock = Stock.where(goods_master_id: params[:id]).update(stock_params)
        
        redirect_to new_stock_path
    end

    private

    def goodsmaster_params
        params.require(:goods_master).permit(:id, :goods_name, :price, :about)
    end

    def stock_params
        params.require(:goods_master).permit(:id)
    end

    def admin_login
        if @current_user and @current_user.admin == "true"
        else
          redirect_to root_path
        end
    end
    

end
