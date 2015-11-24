require 'rails_helper'

RSpec.describe StoreParser do
  subject {described_class.new}

  describe "#object" do
    it "returns a store object" do
      expect(subject.object).to be_a(Store)
    end
  end

  describe "#parse_store" do
    let(:data) {JSON.parse(fixture("store_data.json").read)}

    subject { described_class.new.parse_store(data.keys.first, data[data.keys.first]) }
  
    it "populates a store instance with the store data" do
      expect(subject.name).to eq("Glasgow")
      expect(subject.experiences.count).to eq 3
      expect(subject.experiences.first.reasons.count).to eq 3
    end
  end

end