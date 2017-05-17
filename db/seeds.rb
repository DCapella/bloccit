require 'random_data'

5.times do
  User.create!(
    name:     RandomData.random_name,
    email:    RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users = User.all

15.times do
  Topic.create!(
    name:        RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end
topics = Topic.all

50.times do
  post = Post.create!(
  user:  users.sample,
  topic: topics.sample,
  title: RandomData.random_sentence,
  body:  RandomData.random_paragraph
  )

  # From post get the update_attribute function to get a random time.
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  # 1 to 5 times From post get the attribute votes and From votes get the
  # create fucntion and call it with sample parameters of value: [-1, 1] and
  # user: users
  rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end
posts = Post.all

100.times do
  Comment.create!(
  user: users.sample,
  post: posts.sample,
  body: RandomData.random_paragraph
  )
end

# Create an admin user
admin = User.create!(
  name:     'Admin David',
  email:    'david@admin.com',
  password: 'password',
  role:     'admin'
)

# Create a member
member = User.create!(
  name:     'Member David',
  email:    'd_capella@yahoo.com',
  password: 'password'
)


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
