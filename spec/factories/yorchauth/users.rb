FactoryBot.define do
  factory :yorchauth_user, class: 'Yorchauth::User' do
    trait :with_email do
      email { "user@example.com" }
    end

    trait :with_password do
      password { "mypassword" }
      password_confirmation { "mypassword" }
    end
  end
end
