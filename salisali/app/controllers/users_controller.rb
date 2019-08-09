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

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(@current_user.id)
  end

  def update
    admin_login

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
