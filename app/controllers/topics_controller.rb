class TopicsController < ApplicationController
  def index
    @topics = Topic.with_read_marks_for(current_user).page(params[:page]).order('last_activity_at DESC')
  end


  def new
    authorize! :create, Topic
    @topic = Topic.new
  end


  def create
    authorize! :create, Topic
    topic = current_user.topics.create!(topic_params.merge(last_activity_at: Time.current))
    topic.tag_with(tag_names)
    redirect_to(topic)
  end


  def show
    @topic   = Topic.with_score_values_for(current_user).find(params[:id])
    @replies = @topic.replies.page(params[:page]).order('created_at ASC').with_score_values_for(current_user)
    current_user.read_topic(@topic, @replies.last) if current_user
  end


  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic
  end


  def update
    topic = Topic.find(params[:id])
    authorize! :update, topic
    topic.update_attributes!(topic_params)
    topic.tag_with(tag_names)
    redirect_to(topic)
  end


  def tag
    topic = Topic.find(params[:id])
    authorize! :tag, topic
    topic.tag_with(tag_names)
    redirect_to(topic)
  end


  def score
    topic = Topic.find(params[:id])
    authorize! :score, topic
    current_user.score(topic, score_value)
    redirect_to(:back)
  end


  private

  def topic_params
    params[:topic].permit(:title, :content)
  end


  def tag_names
    params[:tag_names].split(/,| /).reject(&:blank?)
  end


  def score_value
    case params[:vote]
    when 'positive' then Score::POSITIVE
    when 'negative' then Score::NEGATIVE
    else Score::NEUTRAL
    end
  end
end
