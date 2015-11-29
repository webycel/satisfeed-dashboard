require 'rails_helper'

RSpec.describe AmountPerformance do
  subject { described_class }

  describe "identifying best and worst performing stores by number of experiences" do
    let(:best_store) { double(:store) }
    let(:worst_store) { double(:store) }
    let(:stores) { [best_store, worst_store] }

    before do
      allow(subject).to receive(:parsed_stores) { stores }
    end

    context "best store" do
      before do
        allow(best_store).to receive(:good_experiences) { [double(:experience), double(:experience)] }
        allow(worst_store).to receive(:good_experiences) { [double(:experience)] }
      end
      it "returns the store with the highest number of good experiences" do
        expect(AmountPerformance.get_best_store).to eq best_store
      end
    end

    context "worst store" do
      before do
        allow(best_store).to receive(:bad_experiences) { [double(:experience)] }
        allow(worst_store).to receive(:bad_experiences) { [double(:experience), double(:experience)] }
      end
      it "returns the store with the highest number of bad experiences" do
        expect(AmountPerformance.get_worst_store).to eq worst_store
      end
    end
  end

end