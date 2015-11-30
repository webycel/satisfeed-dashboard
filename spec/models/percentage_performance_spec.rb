require 'rails_helper'

RSpec.describe PercentagePerformance do
  subject { described_class }

  describe "identifying best and worst performing stores by percentage" do
    let(:best_store) { double(:store, good_percentage: 80, bad_percentage: 20 ) }
    let(:worst_store) { double(:store, good_percentage: 20, bad_percentage: 80 ) }
    let(:stores) { [best_store, worst_store] }

    before do
      allow(subject).to receive(:parsed_stores) { stores }
    end

    context "best store" do
      it "returns the store with the highest percentage of good ratings" do
        expect(PercentagePerformance.get_best_store).to eq best_store
      end
    end

    context "worst store" do
      it "returns the store with the highest percentage of good ratings" do
        expect(PercentagePerformance.get_worst_store).to eq worst_store
      end
    end
  end

end