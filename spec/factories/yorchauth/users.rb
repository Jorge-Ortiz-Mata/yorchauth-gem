FactoryBot.define do
  factory :yorchauth_user, class: 'Yorchauth::User' do
    trait :with_email do
      email { "user@email.com" }
    end

    trait :with_short_password do
      password { "pass" }
      password_confirmation { "pass" }
    end

    trait :with_long_password do
      password { "123password" }
      password_confirmation { "123password" }
    end

    trait :as_active do
      active { true }
    end
  end
end
