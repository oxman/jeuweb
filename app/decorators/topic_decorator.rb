# encoding: utf-8
class TopicDecorator < Draper::Decorator
  decorates_association :author
  delegate_all


  def replies_count
    label = case source.replies_count
    when 0 then 'Aucune réponse'
    when 1 then 'Une réponse'
    else h.pluralize(source.replies_count, 'réponse')
    end
    ('<i class="icon-comments"></i> ' + label).html_safe
  end


  def tags
    source.tags.map do |tag|
      h.link_to(tag.name, nil)
    end.join(' ').html_safe
  end
end
