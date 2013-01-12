class TopicsController < ApplicationController
  def index
    @topics = Topic.page(params[:page])
  end


  def new
    @topic = Topic.new
  end


  def create
    topic = current_user.topics.create(topic_params)
    redirect_to(topic)
  end


  def show
    @topic = Topic.find(params[:id])
  end


  private

  def topic_params
    params[:topic].permit(:title, :content)
  end
end
