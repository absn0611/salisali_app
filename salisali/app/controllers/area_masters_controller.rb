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
        if params[:id] !="" and params[:area_name] != "" and params[:distance_from_store].to_i > 0 and AreaMaster.find_by(id: params[:id]) == nil and AreaMaster.find_by(area_name: params[:area_name]) == nil
      
            render "area_masters/new"
            return
    
        else

        if params[:id] == ""
            flash.now[:notice] = "エリアコードを指定してください"
        end
  
        if params[:area_name] == ""
          flash.now[:notice2] = "エリア名を指定してください"
        end
  
        if params[:distance_from_store].to_i <= 0
            flash.now[:notice3] = "倉庫からの距離を０以上の値で指定してください"
        end

        if AreaMaster.where(id:params[:id]).any?
            @area_masters = AreaMaster.all

            flash.now[:notice] = params[:id] + "は既に登録されています"
        end

        if AreaMaster.where(area_name:params[:area_name]).any?
            @area_masters = AreaMaster.all

            flash.now[:notice] = params[:area_name] + "は既に登録されています"
        end
        @area_masters = AreaMaster.all

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
