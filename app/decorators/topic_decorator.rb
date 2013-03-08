# encoding: utf-8
class TopicDecorator < Draper::Decorator
  decorates_association :author
  delegate_all


  def replies_count
    ("<i class='icon-comments'></i> #{source.replies_count}").html_safe
  end


  def tags
    source.tags.decorate.map do |tag|
      h.content_tag(:li, tag.label)
    end.join.html_safe
  end
end
