require 'rails_helper'

RSpec.describe Store do

  describe ".get_by_experience" do
    let(:data) { JSON.parse(fixture("experience.json").read) }

    it "returns an array of experiences by rating" do
      expect(Store.get_by_experience(data["experiences"], 'bad').count).to eq 2
    end
  end

end