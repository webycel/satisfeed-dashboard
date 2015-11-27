require 'rails_helper'

RSpec.describe Store do
  subject { described_class.new }
  let(:store_data) { JSON.parse(fixture("stores.json").read) }

  describe ".stores" do
    let(:subject) { described_class }
    let(:firebase) { double(:firebase) }
    let(:firebase_response) { double(:firebase_response) }
    before do
      subject.firebase = firebase
      allow(firebase).to receive(:get).and_return(firebase_response)
      allow(firebase_response).to receive(:body).and_return(store_data)
    end
    it "gets the data from Firebase and parses it into store objects" do
      expect(StoresParser).to receive(:parse).with(store_data)
      subject.stores
    end
  end

  describe ".ranked_by_percentage" do
    let(:subject) { described_class}
    let(:good_store) {double(:store, good_percentage: 80)}
    let(:bad_store) {double(:store, good_percentage: 20)}
    let(:rubbish_store) {double(:store, good_percentage: 0)}
    let(:excellent_store) {double(:store, good_percentage: 100)}
    let(:store_instances) {[good_store,bad_store,rubbish_store,excellent_store]}
    
    before do 
      allow(subject).to receive(:stores).and_return(store_instances)
    end
      
    it "returns array of stores sorted in reverse order by its percentage score" do
      expect(subject.ranked_by_percentage).to eq [excellent_store,good_store,bad_store,rubbish_store]
    end
  end

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
    context "#with no params" do
      let(:experiences) { [double(:experience), double(:experience)]}
      it "returns all experiences" do
        subject.experiences = experiences
        expect(subject.filter_experiences).to eq experiences
      end
    end
    context "received today" do
      let(:today_experience) {double(:experience, from_today?: true)}
      it "returns all experiences from today" do
        subject.experiences = [today_experience]
        expect(subject.todays_experiences).to eq [today_experience]
      end
    end

    context "received yesterday" do
      let(:yesterday_experience) {double(:experience, from_yesterday?: true)}
      it "returns all experiences from yesterday" do
        subject.experiences = [yesterday_experience]
        expect(subject.yesterdays_experiences).to eq [yesterday_experience]
      end
    end
  end

end