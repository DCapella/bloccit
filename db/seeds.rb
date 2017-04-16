require 'random_data'

50.times do
  Post.create!(
  title: RandomData.random_sentence,
  body: RandomData.random_paragraph
  )
end
posts = Post.all

100.times do
  Comment.create!(
  post: posts.sample,
  body: RandomData.random_paragraph
  )
end

Post.find_or_create_by!(title: "Now done with assignment 17", body: "Success.")
assignment = Post.find_or_create_by!(title: "Now done with assignment 17", body: "Success.")
Comment.find_or_create_by!(post: assignment, body: "This might or might not work.")

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
