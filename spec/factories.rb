FactoryGirl.define do
  factory :build do
    repo

    trait :failed_build do
      violations ['WhitespaceRule on line 34 of app/models/user.rb']
    end
  end

  factory :repo do
    sequence(:full_github_name) { |n| "user/repo#{n}" }
    sequence(:github_id) { |n| n }
    private false
    in_organization false

    trait :active do
      active true
    end

    trait :inactive do
      active false
    end

    after(:create) do |repo|
      if repo.users.empty?
        repo.users << create(:user)
      end
    end
  end

  factory :user do
    sequence(:github_username) { |n| "github#{n}" }

    trait :with_email do
      sequence(:email_address) { |n| "jimtom+#{n}@example.com" }
    end
  end

  factory :membership do
    user
    repo
  end

  factory :subscription do
    user
    repo
    sequence(:stripe_subscription_id) { |n| "stripesubscription#{n}" }
  end
end
