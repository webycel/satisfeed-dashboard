require 'rails_helper'

RSpec.describe Store do

  describe ".get_by_experience" do
    let(:data) { JSON.parse(fixture("experience.json").read) }

    it "returns an array of experiences by rating" do
      expect(Store.get_by_experience(data, 'bad').count).to eq 2
    end
  end

  describe ".filter_by_date" do
    let(:data) { JSON.parse(fixture("experience.json").read) }

    context "for today" do
      it "returns an array of experiences by rating" do
        expect(Store.filter_by_date("today", data).count).to eq 0
      end
    end

    context "for yesterday" do 
      it "returns an array of experiences by rating" do
        expect(Store.filter_by_date("yesterday", data).count).to eq 4
      end
    end
  end

end