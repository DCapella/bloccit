class PostsController < ApplicationController
  def info(create)
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    if create
      @topic = Topic.find(params[:topic_id])
      @post.topic = @topic
    end
    if @post.save
      if create
        flash[:notice] = "Post was saved."
        redirect_to [@topic, @post]
      else
        flash[:notice] = "Post was updated."
        redirect_to [@post.topic, @post]
      end
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @post = Post.new
    info(true)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    info(false)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was delete successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "there was an error deleting the post."
      render :show
    end
  end
end
