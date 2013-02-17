class TagDecorator < Draper::Decorator
  delegate_all

  def label
    if h.searched_tags.nil?
      url = h.topics_search_path(tags: name)
      h.link_to(name, url, class: %W( tag tag-#{id} ))
    elsif h.searched_tags.map(&:id).include?(id)
      tag_names = h.searched_tags.map(&:name).reject { |name| name == self.name }
      url       = h.topics_search_path(tags: tag_names.join(','))
      h.link_to("<i class='icon-minus-sign'></i> #{name}".html_safe, url, class: %W( tag tag-#{id} active ))
    else
      tag_names = h.searched_tags.map(&:name).append(name)
      url       = h.topics_search_path(tags: tag_names.join(','))
      h.link_to("<i class='icon-plus-sign'></i> #{name}".html_safe, url, class: %W( tag tag-#{id} ))
    end
  end
end
