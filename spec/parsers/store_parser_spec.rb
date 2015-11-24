require 'rails_helper'

RSpec.describe StoreParser do
  subject {described_class.new}

  describe "#object" do
    it "returns a store object" do
      expect(subject.object).to be_a(Store)
    end
  end

  describe "#parse_store" do
    subject { described_class.new.parse_store(data.keys.first, data[data.keys.first]) }
    let(:data) {JSON.parse(fixture("store_data.json").read)}
  
    it "populates a store instance with the store data" do
      expect(subject.name).to eq("Glasgow")
      expect(subject.experiences.count).to eq 3
      expect(subject.experiences.first.id).to eq "-K3ocQ4vy5PmiuiTFqiZ"
      expect(subject.experiences.first.description).to eq "good"
      expect(subject.experiences.first.extra_info).to eq "staff helpful"
      expect(subject.experiences.first.created_at).to eq "Mon Nov 23 2015 13:56:30 GMT+0000 (GMT)"
      expect(subject.experiences.first.reasons.count).to eq 3
      expect(subject.experiences.first.reasons.first.description).to eq "Condition of parcel"
    end
  end

end