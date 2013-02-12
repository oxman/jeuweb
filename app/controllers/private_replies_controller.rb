class PrivateRepliesController < ApplicationController
  def create
    topic = Topic.find(params[:topic_id])
    authorize! :reply, topic
    topic.replies.add(author: current_user, content: params[:reply][:content])
    replies = topic.replies.page(1).order('created_at ASC')
    redirect_to(private_topic_path(topic, page: replies.num_pages))
  end


  def edit
    @topic = Topic.find(params[:topic_id])
    @reply = @topic.replies.find(params[:id])
    authorize! :reply, @topic
    authorize! :update, @reply
  end


  def update
    topic = Topic.find(params[:topic_id])
    reply = topic.replies.find(params[:id])
    authorize! :reply, topic
    authorize! :update, reply
    reply.update_attributes!(content: params[:reply][:content])
    page = (topic.replies.where('created_at <= ?', reply.created_at).order('created_at ASC').count.to_f / Reply.default_per_page).ceil
    redirect_to(private_topic_path(topic, page: page))
  end
end
