FactoryGirl.define do
  factory :score do
    user { FactoryGirl.create(:user) }

    factory :positive_score do
      value 1
    end

    factory :negative_score do
      value -1
    end
  end
end
