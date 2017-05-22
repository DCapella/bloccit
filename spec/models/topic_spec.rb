require 'rails_helper'
require 'random_data'

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }
  let(:public) { true }

  context "attributes" do
    it "responds to name and description attributes" do
      expect(topic).to have_attributes(name: topic.name, description: topic.description)
    end

    it "is public by default" do
      expect(topic.public).to be(true)
    end

    it { is_expected.to have_many(:posts) }
  end
end
