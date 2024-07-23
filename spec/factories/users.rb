FactoryBot.define do
    factory :user do
      id                                 {0}
      name                               {"test"}
      email                              {"test@gmail.com"}
      password                           {"testtest"}
      password_confirmation              {"testtest"}
    end
  end
  