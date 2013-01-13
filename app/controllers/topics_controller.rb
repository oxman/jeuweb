class TopicsController < ApplicationController
  def index
    @topics = Topic.page(params[:page]).order('last_activity_at DESC')
  end


  def new
    authorize! :create, Topic
    @topic = Topic.new
  end


  def create
    authorize! :create, Topic
    topic = current_user.topics.create!(topic_params.merge(last_activity_at: Time.current))
    redirect_to(topic)
  end


  def show
    @topic   = Topic.find(params[:id])
    @replies = @topic.replies.page(params[:page]).order('created_at ASC')
  end


  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic
  end


  def update
    topic = Topic.find(params[:id])
    authorize! :update, topic
    topic.update_attributes!(topic_params)
    redirect_to(topic)
  end


  private

  def topic_params
    params[:topic].permit(:title, :content)
  end
end
