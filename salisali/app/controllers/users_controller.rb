class UsersController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]

  def index
    admin_login
    
    @users = User.all.order(created_at:'asc')
  end

  def new
    admin_login

    @user = User.new
  end

  def create
    admin_login

    if @user_name = User.where(name:params[:user][:name]).any? or @user_mail = User.where(mail:params[:user][:mail]).any?


      if @user_name == true
        flash.now[:notice] = params[:user][:name].to_s + "は既に登録されています"
      end

      if @user_mail == true
        flash.now[:notice2] = params[:user][:mail].to_s + "は既に登録されています"
      end

      @user = User.new

      render "new"
      # render plain: params[:user][:name].inspect
      return
    else


    
    @user = User.new(user_params)
      if @user.save
        redirect_to login_path, notice: "登録しました"
        return

      else
        flash.now[:notice] = "値が間違っています。"
        render 'new'
        return
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(@current_user.id)
  end

  def update
    admin_login

    @user = User.find(params[:user][:id])
    @users = User.all

    @presence = User.where(name:params[:user][:name]).any?
    @presence2 = User.where(mail:params[:user][:mail]).any?
    @presence3 = User.where(area_master_id:params[:user][:area_master_id]).any?


    # render plain: @presence3.inspect
    # return

    if @presence == true and @user.name != params[:user][:name]
        flash.now[:notice] = params[:user][:name] + "は既に登録があります"

        render "index"
        return
    end

    if @presence2 == true and @user.mail != params[:user][:mail]
        flash.now[:notice] = params[:user][:mail] + "は既に登録があります"

        render "index"
        return
    end

    if @presence3 == false
      flash.now[:notice] = "エリアコード"  + params[:user][:area_master_id] + "は存在しません"

      render "index"
      return
    end



    @user = User.where(id:params[:user][:id]).update(user_params)
    if @current_user.admin == "true"
    redirect_to users_path, notice: params[:user][:name] + 'の情報を更新しました' 
    else
    redirect_to user_path, notice: params[:user][:name] + 'の情報を更新しました' 
    end
  end

  def destroy
    admin_login
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
    # render plain: @user.inspect
  end

  private

    def user_params
      params.require(:user).permit(:name, :mail, :password, :password_confirmation, :area_master_id, :address, :admin)
    end

    def admin_login
      if @current_user and @current_user.admin == "true"
      else
        redirect_to root_path
      end
    end

end
