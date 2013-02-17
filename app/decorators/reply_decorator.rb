class ReplyDecorator < Draper::Decorator
  decorates_association :author
  delegate_all
end
