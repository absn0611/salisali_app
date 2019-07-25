class OrdersController < ApplicationController
    def index
        @orders = Order.all
    end

    def new
    end

    def create
    end

    def edit
    end
end
