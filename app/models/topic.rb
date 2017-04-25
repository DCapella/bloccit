class Topic < ApplicationRecord
  has_many :sponsored_posts, dependent: :destroy
  has_many :posts, dependent: :destroy
end
