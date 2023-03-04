FactoryBot.define do
  factory :yorchauth_user, class: 'Yorchauth::User' do
    trait :with_email do
      email { "user@example.com" }
    end

    trait :with_short_password do
      password { "pass" }
      password_confirmation { "pass" }
    end

    trait :with_long_password do
      password { "password268" }
      password_confirmation { "password268" }
    end
  end
end
