class SponsoredPostsController < ApplicationController
  def info(create)
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    if create
      @topic = Topic.find(params[:topic_id])
      @sponsored_post.topic = @topic
    end
    if @sponsored_post.save
      if create
        flash[:notice] = "Sponsored Post was saved."
        redirect_to [@topic, @sponsored_post]
      else
        flash[:notice] = "Sponsored Post was updated."
        redirect_to [@sponsored_post.topic, @sponsored_post]
      end
    else
      flash.now[:alert] = "There was an error saving the sponsored post. Please try again."
      render :new
    end
  end

  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def create
    @sponsored_post = SponsoredPost.new
    info(true)
  end

  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    info(false)
  end

  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])
    if @sponsored_post.destroy
      flash[:notice] = "\"#{@sponsored_post.title}\" was deleted successfully."
      redirect_to @sponsored_post.topic
    else
      flash.now[:alert] = "there was an error deleting the sponsored post."
      render :show
    end
  end
end
