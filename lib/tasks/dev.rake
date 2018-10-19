namespace :dev do
  
  # 假使用者
  task fake_user: :environment do
    # 避免刪到種子資料
    User.all.each do |user|
      if (user.email != "admin@example.com") and (user.email != "test@test.com")
        user.destroy
      end
    end

    15.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

end