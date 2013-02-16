class UserDecorator < Draper::Decorator
  delegate_all


  def avatar(size)
    h.content_tag :div, class: 'avatar', title: name do
      h.image_tag(avatar_url, size: "#{size}x#{size}")
    end
  end
end
