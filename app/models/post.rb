class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  has_many :comments, dependent: :destroy
  # Associate votes to Post; allowing us to call post.votes;
  # dependent: ensure votes are destroyed when their parent
  # .. post is deleted
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  default_scope { order('rank DESC') }
  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

  validates :title, length: { minimum: 5 },  presence: true
  validates :body,  length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user,  presence: true

  def up_votes
    # From votes call the where function, and call it with value: 1 as parameter
    # ..  to fetch the votes with value 1; then from the return of where call the
    # .. count function
    votes.where(value: 1).count
  end

  def down_votes
    # From votes call the where function, and call it with parameter value: -1 to
    # .. fetch the votes with value -1; then from the return of where, call the
    # .. count function
    votes.where(value: -1).count
  end

  def points
    # From votes call the ActiveRecord's sum function with parameter :value
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end
end
