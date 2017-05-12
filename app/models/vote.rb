class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_save :update_post

  # For value, set inclusion: with parameter (in: [-1, 1]) to ensure that value is
  # .. either -1 or 1; Else message: will display; set presence to true.
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }, presence: true

  private
  def update_post
    post.update_rank
  end
end
