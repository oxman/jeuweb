FactoryGirl.define do
  factory :topic do
    sequence(:title) { |n| "Topic #{n}" }
    content { "Content for topic." }
  end
end
