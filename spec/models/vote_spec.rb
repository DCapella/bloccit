require 'rails_helper'

RSpec.describe Vote, type: :model do
  # Creating a topic with keys: name and description
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  # Creating a user with keys: name, email, and password
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  # From topic creating a post with values title, body, and user from user
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  # Creating a vote with keys: value, post from post, and user from user
  let(:vote) { Vote.create!(value: 1, post: post, user: user) }

  # testing that votes belong to posts and users
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  # test that value exists when votes are created
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) }

  describe "update_post callback" do
    it "triggers update_post on save" do
      expect(vote).to receive(:update_post).at_least(:once)
      vote.save!
    end

    it "#update_post should call update_rank on post" do
      expect(post).to receive(:update_rank).at_least(:once)
      vote.save!
    end
  end
end