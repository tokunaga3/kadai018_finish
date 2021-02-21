10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               user_content: Faker::Games::SuperMario,
               address: Faker::Games::Pokemon.location,
               )
end

15.times do |n|
  Event.create!(
    user: User.offset(rand(Event.count)).first,
    date: "2021/#{rand(1..12)}/#{rand(1..25)}",
    title: Faker::Games::SuperMario.character,
    content: Faker::Games::SuperMario.character,
    start_point: Faker::Games::SuperMario.location,
    goal_point: Faker::Games::SuperMario.location,
    status: "車",
    carry_price: "#{rand(10)}00",
               )
end

15.times do |n|
  Event.create!(
    user: User.offset(rand(Event.count)).first,
    date: "2021/#{rand(1..12)}/#{rand(1..25)}",
    title: Faker::Games::SuperMario.character,
    content: Faker::Games::SuperMario.character,
    start_point: Faker::Games::SuperMario.location,
    goal_point: Faker::Games::SuperMario.location,
    status: "乗",
    carry_price: "#{rand(10)}00",
               )
end
