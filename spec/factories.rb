FactoryGirl.define do
  factory :family_sitter do
    
  end
  factory :invite do

  end
  factory :family do
    name "Eves"
  end

  factory :user do |user|
    user.first_name                   "Test User"
    user.email                  "user@example.com"
    user.password               "password"
    user.password_confirmation  "password"
  end

  factory :favorite, class: Favorite do
    name "New Favorite"
  end

  factory :kid, class: Kid do
    gender "Female"
  end

  trait :person_bryar do
    name "Bryar Louise"
    birthdate Date.new(2016, 7, 24)
  end

  trait :person_goji do
    name "Goji Neehow"
    birthdate Date.new(2009, 9, 9)
  end
end
