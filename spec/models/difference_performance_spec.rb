require 'rails_helper'

RSpec.describe DifferencePerformance do
  subject { described_class }

  describe "identifying best and worst performing stores by ratings comparison" do
    let(:best_store) { double(:store, positive_ratings_difference: 8, negative_ratings_difference: 4 ) }
    let(:worst_store) { double(:store, positive_ratings_difference: 3, negative_ratings_difference: 7 ) }
    let(:stores) { [best_store, worst_store] }

    before do
      allow(subject).to receive(:parsed_stores) { stores }
    end

    context "best store" do
      it "returns the store with the highest difference of good vs bad ratings" do
        expect(DifferencePerformance.get_best_store).to eq best_store
      end
    end

    context "worst store" do
      it "returns the store with the highest difference of bad vs good ratings" do
        expect(DifferencePerformance.get_worst_store).to eq worst_store
      end
    end
  end

end