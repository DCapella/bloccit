class TopicsController < ApplicationController
  def info(create)
    @topic.name = params[:topic][:name]
    @topic.description = params[:topic][:description]
    @topic.public = params[:topic][:public]

    if @topic.save
      if create
        redirect_to @topic, notice: "Topic was saved successfully."
      else
        flash[:notice] = "Topic was updated."
        redirect_to @topic
      end
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new
    info(true)
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    info(false)
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "there was an error deleting the topic."
      render :show
    end
  end

end
