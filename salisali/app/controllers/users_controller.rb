class UsersController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]

  def index
    @users = User.all.order(created_at:'asc')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render 'new'
    end
  end

  def edit
    # render plain: params.inspect
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(@current_user.id)
  end

  def update
    # render plain: params[:id].inspect
    @user = User.where(id:params[:user][:id]).update(user_params)
    # render plain: params[:user][:id].inspect
    if @current_user.admin == "true"
    redirect_to users_path, notice: params[:user][:name] + 'の情報を更新しました' 
    else
    redirect_to user_path, notice: params[:user][:name] + 'の情報を更新しました' 
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
    # render plain: @user.inspect
  end

  private

    def user_params
      params.require(:user).permit(:name, :mail, :password, :password_confirmation, :area_master_id, :address, :admin)
    end

end
