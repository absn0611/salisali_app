class AreaMastersController < ApplicationController
    def index
        admin_login
        @area_masters = AreaMaster.all
    end

    def edit
        admin_login
        @area_master = AreaMaster.find(params[:id])
    end

    def destroy
        admin_login
        @area_master = AreaMaster.find(params[:id])
        @area_master.destroy
        redirect_to area_masters_path
    end

    def update
        admin_login
        @area_master = AreaMaster.where(id: params[:id]).update(areamaster_params)

        redirect_to area_masters_path
    end

    def new
        admin_login
        if AreaMaster.where(id:params[:id]).any?
            @area_masters = AreaMaster.all

            flash.now[:notice] = params[:id] + "は既に登録されています"
            render "index"
        return
        end

        if AreaMaster.where(area_name:params[:area_name]).any?
            @area_masters = AreaMaster.all

            flash.now[:notice] = params[:area_name] + "は既に登録されています"
            render "index"
        return
        end
    
    
        # render plain: params.inspect
    end

    def create
        admin_login

        @area_master = AreaMaster.create(id:params[:id],area_name:params[:area_name],distance_from_store:params[:distance_from_store])
        redirect_to area_masters_path
    end

    private

    def areamaster_params
        params.require(:area_master).permit(:id, :area_name, :distance_from_store)
    end

    def admin_login
        if @current_user and @current_user.admin == "true"
        else
          redirect_to root_path
        end
    end

end
