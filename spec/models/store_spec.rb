RSpec.describe Store do

  subject { described_class.new }

  describe ".get_by_experience" do
    let(:products) { [product1, product2] }
    let(:product1) { double(:product)}
    let(:product2) { double(:product)}

    before do
      allow(product1).to receive(:price) {30.0}
      allow(product2).to receive(:price) {35.0}
    end

    it "returns an array of experiences by rating" do
      subject.products = products
      expect(subject.total_price).to eq 65.0
    end
  end

end