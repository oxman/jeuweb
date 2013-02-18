# encoding: utf-8
class TopicDecorator < Draper::Decorator
  decorates_association :author
  delegate_all


  def replies_count
    ("<i class='icon-comments'></i> #{source.replies_count}").html_safe
  end


  def tags
    source.tags.decorate
      .map { |tag| tag.label }
      .join(' ').html_safe
  end
end
