# encoding: utf-8
class TopicDecorator < Draper::Decorator
  decorates_association :author
  delegate_all


  def replies_count
    label = source.replies_count == 0 ? 'Aucune réponse' : h.pluralize(source.replies_count, 'réponse')
    ('<i class="icon-comments"></i> ' + label).html_safe
  end


  def tag_names
    source.tags.map do |tag|
      h.link_to(tag.name, nil)
    end.join(' ').html_safe
  end
end
