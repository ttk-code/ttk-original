class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_post, only: [:show,:edit, :update, :destroy]
  before_action :ensure_correct_user, {only: [:edit]}

  def show

    @comments = @post.comments.all
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = '更新されました'
      redirect_to @post
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
       render :new
    end
  end



  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to "/", notice: '投稿を削除しました' }
      format.json { head :no_content }
    end

    #@cm=current_user.comments.find_by(id: params[:id])
   # @cm.destroy
    #flash[:success] = 'コメントを削除しました。'
    #redirect_back(fallback_location: root_path)
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:image, :title, :text)
    end

    def ensure_correct_user
      if @post.user_id != @current_user.id
       redirect_to root_url
      end
    end
end
