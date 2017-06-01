FactoryGirl.define do
  factory :family do
    name "Eves"
  end
  factory :user do
    first_name "User"
    last_name "Last"
    email "user@kidfo.com"
    password "password123"
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
