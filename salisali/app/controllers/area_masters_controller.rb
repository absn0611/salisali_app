class AreaMastersController < ApplicationController
    def index
        admin_login
        @area_master = AreaMaster.new

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
        @area_master = AreaMaster.new

        # render plain: params.inspect
        # return

        if params[:area_master][:id] !="" and params[:area_master][:area_name] != "" and params[:area_master][:distance_from_store].to_i > 0 and AreaMaster.find_by(id: params[:area_master][:id]) == nil and AreaMaster.find_by(area_name: params[:area_master][:area_name]) == nil
      
            render "area_masters/new"
            return
    
        else

        if params[:area_master][:id] == ""
            flash.now[:notice] = "エリアコードを指定してください"
        end
  
        if params[:area_master][:area_name] == ""
          flash.now[:notice2] = "エリア名を指定してください"
        end
  
        if params[:area_master][:distance_from_store].to_i <= 0
            flash.now[:notice3] = "倉庫からの距離を０以上の値で指定してください"
        end

        if AreaMaster.where(id:params[:area_master][:id]).any?
            @area_masters = AreaMaster.all

            flash.now[:notice] = params[:area_master][:id] + "は既に登録されています"
        end

        if AreaMaster.where(area_name:params[:area_master][:area_name]).any?
            @area_masters = AreaMaster.all

            flash.now[:notice2] = params[:area_master][:area_name] + "は既に登録されています"
        end
        @area_masters = AreaMaster.all

        render "index"
        return

    end
    
    
        # render plain: params.inspect
    end

    def create
        admin_login

        # render plain: params.inspect
        # return 

        @area_master = AreaMaster.create(areamaster_params)
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
