FactoryBot.define do
  factory :task do
    sequence :title do |n|
      "Test task #{n}"
    end

    sequence :description do |n|
      "This is the number #{n} test task"
    end

    user

    trait :complete do
      status { 'complete' }
    end

    trait :incomplete do
      status { 'incomplete' }
    end

  end
end
