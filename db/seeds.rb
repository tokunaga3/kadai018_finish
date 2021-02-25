10.times do |n|
  gimei = Gimei.new
  email = Faker::Internet.email
  password = "password"
  User.create!(name: gimei.name.kanji,
               email: email,
               password: password,
               user_content: "よろしくお願いします",
               address: gimei.address.kanji,
               )
end

15.times do |n|
  gimei = Gimei.new
  gimei_goarl_point = gimei.address.town.kanji
  user_name = User.offset(rand(Event.count)).first
  unless user_name.nil?
    Event.create!(
      user: user_name,
      date: "2022/#{rand(1..12)}/#{rand(1..25)}",
      title: "#{gimei_goarl_point}まで行きます",
      content: "#{gimei_goarl_point}まで行きます！乗っていきませんか？",
      start_point: gimei.address.prefecture.kanji,
      goal_point: gimei_goarl_point,
      status: "車",
      carry_price: "#{rand(10)}00",
                 )
  end
end

15.times do |n|
  gimei = Gimei.new
  gimei_goarl_point = gimei.address.town.kanji
  user_name = User.offset(rand(Event.count)).first
  unless user_name.nil?
    Event.create!(
      user: user_name,
      date: "2022/#{rand(1..12)}/#{rand(1..25)}",
      title: "#{gimei_goarl_point}まで乗せてください",
      content: "#{gimei_goarl_point}まで行きたいのですがどなたか通りませんか？",
      start_point: gimei.address.prefecture.kanji,
      goal_point: gimei_goarl_point,
      status: "乗",
      carry_price: "#{rand(10)}00",
                 )
  end
end
