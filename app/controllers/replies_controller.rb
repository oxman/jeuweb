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
    redirect_to(topic)
  end


  private

  def reply_params
    params[:reply].permit(:content)
  end
end
