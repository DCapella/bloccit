require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:advertisement) { Advertisement.create!(title: "T", body: "b") }
  context "attributes" do
    it "has title and body attributes" do
      expect(advertisement).to have_attributes(title: "T", body: "b")
    end
  end
end
