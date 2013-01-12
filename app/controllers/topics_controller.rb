class TopicsController < ApplicationController
  def index
    @topics = Topic.page(params[:page]).order('last_activity_at DESC')
  end


  def new
    @topic = Topic.new
  end


  def create
    topic = current_user.topics.create!(topic_params.merge(last_activity_at: Time.current))
    redirect_to(topic)
  end


  def show
    @topic   = Topic.find(params[:id])
    @replies = @topic.replies.page(params[:page]).order('created_at ASC')
  end


  private

  def topic_params
    params[:topic].permit(:title, :content)
  end
end
