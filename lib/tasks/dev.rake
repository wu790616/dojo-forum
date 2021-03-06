namespace :dev do
  
  # 假使用者
  task fake_user: :environment do
    # 避免刪到種子資料
    User.all.each do |user|
      if (user.email != "admin@example.com") and (user.email != "test@test.com")
        user.destroy
      end
    end

    18.times do |i|
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
          edit_time: Time.now,
          views_count: rand(1..300),
          permission: "all"
          )
      end
      3.times do |i|
        user.posts.create!(
          title: FFaker::Book::title,
          content: FFaker::CheesyLingo::paragraph,
          edit_time: Time.now,
          views_count: rand(1..300),
          permission: ["friend", "myself"].sample,
          )
      end
    end
    puts "have create 6 posts in each user"

    # 每個Post，tag 1~3個 category
    Post.all.each do |post|
      rand(1..3).times do |t|
        category = Category.all.sample
        unless post.categories.include?(category)
          post.tagships.create(category: category)
        end
      end
      post.draft = FFaker::Boolean::random
      post.save
    end
    puts"have create fake tagships"
  end

  # 假Reply
  task fake_reply: :environment do
    Reply.destroy_all
    
    Post.all.each do |post|
      rand(1..25).times do |t|
        user = User.all.sample
        post.replies.create(
          user: user,
          content: FFaker::CheesyLingo::sentence
          )
      end
    end

    puts "have create replies for each post"
  end

  # 建立friendship
  task fake_friend: :environment do
    FriendRequest.destroy_all
    Friendship.destroy_all

    User.all.each do |user|
      rand(0..4).times do |t|
        friend = User.all.sample
        if user != friend && user.friends.exclude?(friend)
          user.friends << friend
        end
      end
    end

    puts "have create friendship between all user"
  end

  #=================fake all=================
  task fake_all: :environment do
    puts "fake_user processing..."
    Rake::Task['dev:fake_user'].execute
    puts "fake_post processing..."
    Rake::Task['dev:fake_post'].execute
    puts "fake_reply processing..."
    Rake::Task['dev:fake_reply'].execute
    puts "fake_friend processing..."
    Rake::Task['dev:fake_friend'].execute
  end

end