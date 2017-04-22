require 'random_data'

# 50.times do
#   Post.create!(
#   title: RandomData.random_sentence,
#   body: RandomData.random_paragraph
#   )
# end
# posts = Post.all
#
# 100.times do
#   Comment.create!(
#   post: posts.sample,
#   body: RandomData.random_paragraph
#   )
# end
#
# puts "Seed finished"
# puts "#{Post.count} posts created"
# puts "#{Comment.count} comments created"

# 50.times do
#   Advertisement.create!(
#   title: RandomData.random_sentence,
#   body: RandomData.random_paragraph,
#   price: RandomData.random_price
#   )
# end
# advertisements = Advertisement.all
#
# puts "Seed finished"
# puts "#{Advertisement.count} advertisements created"

50.times do
  Question.create!(
  title: RandomData.random_sentence,
  body: RandomData.random_paragraph,
  resolved: RandomData.random_resolve
  )
end
questions = Question.all

puts "Seed finished"
puts "#{Question.count} questions created"
