class RepliesController < ApplicationController
  def new
    authorize! :create, Reply
    @topic = Topic.find(params[:topic_id])
    @reply = @topic.replies.build
  end


  def create
    authorize! :create, Reply
    topic = Topic.find(params[:topic_id])

    Topic.transaction do
      reply = topic.replies.create!(reply_params.merge(author: current_user))
      topic.update_attributes!(last_reply: reply, last_reply_author: current_user, last_activity_at: Time.current)
    end

    replies = topic.replies.page(1).order('created_at ASC')
    redirect_to(topic_path(topic, page: replies.num_pages))
  end


  def edit
    @topic = Topic.find(params[:topic_id])
    @reply = @topic.replies.find(params[:id])
    authorize! :update, @reply
  end


  def update
    topic = Topic.find(params[:topic_id])
    reply = topic.replies.find(params[:id])
    authorize! :update, reply
    reply.update_attributes!(reply_params)
    page = (topic.replies.where('created_at <= ?', reply.created_at).order('created_at ASC').count.to_f / Reply.default_per_page).ceil
    redirect_to(topic_path(topic, page: page))
  end


  def score
    topic = Topic.find(params[:topic_id])
    reply = topic.replies.find(params[:id])
    authorize! :score, reply
    current_user.score(reply, score_value)
    redirect_to(:back)
  end


  private

  def reply_params
    params[:reply].permit(:content)
  end


  def score_value
    params[:vote] == 'positive' ? Score::POSITIVE : Score::NEGATIVE
  end
end
