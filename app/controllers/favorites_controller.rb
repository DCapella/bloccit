class FavoritesController < ApplicationController
  # First, user must sign in
  before_action :require_sign_in

  def create
    # From post get find function, and call it with params[:post_id] as parameter
    # and set it to post
    post = Post.find(params[:post_id])
    # from current_user get favorites attribute and from favorites attribute
    # get build function, and call it with (post: post) as a parameter
    favorite = current_user.favorites.build(post: post)

    if favorite.save
      flash[:notice] = "Post favorited."
    else
      flash[:alert] = "Favoriting failed."
    end

    redirect_to [post.topic, post]
  end

  def destroy
    # From Post get find function, and call it with (params[:post_id]) as parameter
    # and set it to post
    post = Post.find(params[:post_id])
    # From current_user get favorites attribute and from favorites get find function
    # and call it with (params[:id]) as a parameter
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Post unfavorited."
    else
      flash[:alert] = "Unfavoriting failed."
    end

    redirect_to [post.topic, post]
  end
end
