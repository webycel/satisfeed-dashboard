require 'rails_helper'

RSpec.describe Store do
  subject { described_class.new }

  describe ".get_by_experience" do
    let(:data) { JSON.parse(fixture("experience.json").read) }

    xit "returns an array of experiences by rating" do
      expect(Store.get_by_experience(data, 'bad').count).to eq 2
    end
  end

  describe ".filter_by_date" do
    let(:data) { JSON.parse(fixture("experience.json").read) }

    context "for today" do
      xit "returns an array of experiences by rating" do
        expect(Store.filter_by_date("today", data).count).to eq 0
      end
    end

    context "for yesterday" do 
      xit "returns an array of experiences by rating" do
        expect(Store.filter_by_date("yesterday", data).count).to eq 4
      end
    end
  end

  describe "store experiences" do
    let(:good_experience) {double(:experience, good_experience?: true, bad_experience?: false)}
    let(:bad_experience) {double(:experience, bad_experience?: true, good_experience?: false)}
    let(:experiences) {[good_experience, bad_experience]}
    context "#good_experiences" do
      it "returns only the good experiences a store has received" do
        subject.experiences = experiences
        expect(subject.good_experiences).to eq [good_experience]
      end
    end

    context "#bad_experiences" do
      it "returns only the bad experiences a store has received" do
        subject.experiences = experiences
        expect(subject.bad_experiences).to eq [bad_experience]
      end
    end
  end

end