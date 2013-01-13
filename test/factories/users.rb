FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    email { "#{name.parameterize}@jeuweb.dev" }
    password { name }
    password_confirmation { name }
    persistence_token { name }
  end
end
