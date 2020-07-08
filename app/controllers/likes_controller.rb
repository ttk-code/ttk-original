class LikesController < ApplicationController
  before_action :require_user_logged_in

  def create
   post = Post.find(params[:post_id])
   current_user.like(post)
   flash[:success] = 'お気に入り追加'
   redirect_back(fallback_location: root_path)
  end

  def destroy
   post = Post.find(params[:post_id])
   current_user.unlike(post)
   flash[:success] = 'お気に入り削除'
   redirect_back(fallback_location: root_path)
  end
end
