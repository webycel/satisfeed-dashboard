require 'rails_helper'

RSpec.describe Store do
  subject { described_class.new }

  describe "selecting stores by performance" do
    let(:good_experience) {double(:experience, good_experience?: true, bad_experience?: false)}
    let(:bad_experience1) {double(:experience, bad_experience?: true, good_experience?: false)}
    let(:bad_experience2) {double(:experience, bad_experience?: true, good_experience?: false)}
    let(:today_experience) {double(:experience, experience_from_today?: true)}
    let(:experiences) {[good_experience, bad_experience1, bad_experience2]}
    
    context "#good_experiences" do
      it "returns only the good experiences a store has received" do
        subject.experiences = experiences
        expect(subject.good_experiences).to eq [good_experience]
      end
    end

    context "#bad_experiences" do
      it "returns only the bad experiences a store has received" do
        subject.experiences = experiences
        expect(subject.bad_experiences).to eq [bad_experience1, bad_experience2]
      end
    end

    context "#good_percentage" do
      it "calculates the percentage of good ratings" do
        subject.experiences = experiences
        expect(subject.good_percentage).to eq 33.33
      end
    end

    context "#bad_percentage" do
      it "calculates the percentage of bad ratings" do
        subject.experiences = experiences
        expect(subject.bad_percentage).to eq 66.67
      end
    end

    context "#positive_ratings_difference" do
      it "returns the difference between the number of good and bad experiences" do
        subject.experiences = experiences
        expect(subject.positive_ratings_difference).to eq -1
      end
    end

    context "#negative_ratings_difference" do
      it "returns the difference between the number of good and bad experiences" do
        subject.experiences = experiences
        expect(subject.negative_ratings_difference).to eq 1
      end
    end
  end

  describe "filtering experiences" do
    context "#todays_experiences" do
      let(:today_experience) {double(:experience, from_today?: true)}
      it "returns the experiences created today" do
        subject.experiences = [today_experience]
        expect(subject.todays_experiences).to eq [today_experience]
      end
    end

    context "#yesterdays_experiences" do
      let(:yesterday_experience) {double(:experience, from_yesterday?: true)}
      it "returns the experiences created yesterday" do
        subject.experiences = [yesterday_experience]
        expect(subject.yesterdays_experiences).to eq [yesterday_experience]
      end
    end

  end

end