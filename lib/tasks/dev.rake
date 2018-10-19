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

  # 假Post
  task fake_post: :environment do
    Post.destroy_all

    # 每個user產生3個假Post
    User.all.each do |user|
      3.times do |i|
        user.posts.create!(
          title: FFaker::Book::title,
          content: FFaker::CheesyLingo::paragraph,
          draft: FFaker::Boolean::random
          )
      end
    end
    puts "have create 3 posts in each user"

    # 每個Post，tag 1~3個 category
    Post.all.each do |post|
      rand(1..3).times do |t|
        category = Category.all.sample
        unless post.categories.include?(category)
          post.tagships.create(category: category)
        end
      end
    end
    puts"have create fake tagships"
  end


end