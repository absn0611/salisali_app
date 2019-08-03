class GoodsMastersController < ApplicationController
    
    def new
    end

    def create
        
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

end
