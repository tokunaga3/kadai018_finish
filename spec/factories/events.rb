FactoryBot.define do
  factory :event do
    date {'2022/01/25'}
    title {'event1'}
    content {'aa'}
    start_point {'a'}
    goal_point {'a'}
    carry_price {'100'}
    status {'車'}
    user
    # after(:create) do |task|
    #  create(:label, tasks: [task])
    # end
  end
end
