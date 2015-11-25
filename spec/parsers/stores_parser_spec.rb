require 'rails_helper'

RSpec.describe StoresParser do
  

  describe "when we have data to parse" do
    subject { described_class.parse(data) }
    context "if there is data" do
      let(:data) {JSON.parse(fixture("store_data.json").read)}
      let(:store_name) { data.keys.first }
      let(:store_data) { data[store_name]}

      it "creates a store parser and calls it" do
        parser_instance = double(:parser_instance)
        expect(StoreParser).to receive(:new).and_return(parser_instance)
        expect(parser_instance).to receive(:parse_store).with( "Glasgow", store_data )
        subject
      end
    end
  end

end