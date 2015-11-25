require 'rails_helper'

RSpec.describe Experience do
  let(:subject) { Experience.new }

  describe "#good_experience?" do
    it "indicates if the experience is good" do
      subject.description = "good"
      expect(subject.good_experience?).to be_truthy
    end
  end

  describe "#bad_experience?" do
    it "indicates if the experience is bad" do
      subject.description = "bad"
      expect(subject.bad_experience?).to be_truthy
    end
  end
end