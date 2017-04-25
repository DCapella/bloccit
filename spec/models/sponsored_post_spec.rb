require 'rails_helper'
require 'random_data'

RSpec.describe SponsoredPost, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:price) { RandomData.random_price}

  let(:topic) { Topic.create!(name: name, description: description) }
  let(:sponsoredpost) { topic.sponsored_posts.create!(title: title, body: body, price: price) }
  it { is_expected.to belong_to(:topic) }

  context "attributes" do
    it "has title and body attributes" do
      expect(sponsoredpost).to have_attributes(title: title, body: body, price: price)
    end
  end
end
