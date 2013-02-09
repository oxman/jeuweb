FactoryGirl.define do
  factory :topic do
    sequence(:title) { |n| "Topic #{n}" }
    content "Content for topic."
    author { FactoryGirl.create(:user) }

    factory :private_topic do
      private true
    end
  end
end
