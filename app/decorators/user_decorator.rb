class UserDecorator < Draper::Decorator
  delegate_all


  def avatar(size)
    h.image_tag(avatar_url, alt: name, class: 'avatar', size: "#{size}x#{size}")
  end
end
