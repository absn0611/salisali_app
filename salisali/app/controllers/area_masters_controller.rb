class AreaMastersController < ApplicationController
    def index
        @area_masters = AreaMaster.all
    end

    def edit
        @area_master = AreaMaster.find(params[:id])
    end

    def destroy
        @area_master = AreaMaster.find(params[:id])
        @area_master.destroy
        redirect_to area_masters_path
    end

    def update
        @area_master = AreaMaster.where(id: params[:id]).update(areamaster_params)

        redirect_to area_masters_path
    end

    def new
        # render plain: params.inspect
    end

    def create
        @area_master = AreaMaster.create(id:params[:id],area_name:params[:area_name],distance_from_store:params[:distance_from_store])
        redirect_to area_masters_path
        # render plain: @area_master.inspect


    end

    private

    def areamaster_params
        params.require(:area_master).permit(:id, :area_name, :distance_from_store)
    end

    def areau_params
        params.require(:area_master).permit(:id)
    end


end
