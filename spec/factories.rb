FactoryGirl.define do
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
