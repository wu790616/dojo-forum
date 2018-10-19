# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin Seed
User.create(name: "Admin", email: "admin@example.com", password: "12345678", role: "admin")
puts "Default admin created!"

# Category
Post.destroy_all
Category.destroy_all
category_list = [
  { name: "寵物" },
  { name: "生活" },
  { name: "工作" },
  { name: "愛情" },
  { name: "藝術" },
  { name: "攝影" },
  { name: "設計" },
  { name: "電視" },
  { name: "電影" },
  { name: "閱讀" },
  { name: "音樂" },
  { name: "動漫" },
  { name: "遊戲" },
  { name: "3C" },
  { name: "運動" },
  { name: "旅行" },
  { name: "美食" },
  { name: "時尚" },
  { name: "學習" },
  { name: "理財" },
  { name: "育兒" },
  { name: "日記" },
]

category_list.each do |category|
  Category.create( name: category[:name] )
end
puts "Category created!"