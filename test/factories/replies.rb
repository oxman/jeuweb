FactoryGirl.define do
  factory :reply do
    content "Content for reply."
    author { FactoryGirl.create(:user) }
  end
end
