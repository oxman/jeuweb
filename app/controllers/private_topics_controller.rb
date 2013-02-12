class PrivateTopicsController < ApplicationController
  def index
    @topics = Topic.allowed_for(current_user).page(params[:page]).order('last_activity_at DESC')
  end


  def show
    @topic   = Topic.allowed_for(current_user).find(params[:id])
    @replies = @topic.allowed_replies_for(current_user).page(params[:page]).order('created_at ASC').includes(:author)
    current_user.read_topic(@topic, @replies.last)
  end


  def new
    authorize! :create, Topic
    @topic = Topic.new
  end


  def create
    authorize! :create, Topic
    topic_params = params[:topic].permit(:title, :content, :participant_names).merge(private: true)
    topic_params[:participant_names] = topic_params[:participant_names].gsub(/\s+/, '').split(',') << current_user.name
    topic = current_user.topics.create!(topic_params.merge(last_activity_at: Time.current))
    redirect_to(private_topic_path(topic))
  end


  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic
  end


  def update
    topic = Topic.find(params[:id])
    authorize! :update, topic
    topic_params = params[:topic].permit(:title, :content)
    topic.update_attributes!(topic_params)
    redirect_to(private_topic_path(topic))
  end
end
