class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index,:show, :followings, :followers, :likes, :edit, :update, :destroy]

  def index
    @users = User.order(id: :desc).page(params[:page]).per(25).where('name LIKE ?', "%#{params[:search]}%")

  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '更新されました'
      redirect_to @user
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def destroy

  end


  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end

  def likes
    @user = User.find(params[:id])
    @likings = @user.likings.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def search


  end

   private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :new_profile_picture, :image)
  end
end