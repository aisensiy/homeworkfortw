require "spec_helper"
require 'hotel'

describe Hotel do

  subject {Hotel.new "Lakewood", 3}

  context "price" do
    it "should == 100 with weekday and regular" do
      subject.price("Regular", "mon").should == 110
      subject.price("Regular", "sun").should == 90
      subject.price("Rewards", "sun").should == 80
      subject.price("Rewards", "tues").should == 80
    end
  end

  context "basic attrs" do
    its(:name) { should == "Lakewood" }
    its(:rating) { should == 3 }
    it { should respond_to(:price) }
  end

  context "match day" do
    let(:elsedays) { %w(abc dda monday)}

    it "match sun and sat as weekend" do
      Hotel::WEEKEND.each do |day|
        subject.weekend?(day).should be_true
      end

      Hotel::WEEKDAY.each do |day|
        subject.weekend?(day).should be_false
      end

      elsedays.each do |day|
        subject.weekend?(day).should be_false
      end
    end

    it "match 1-5 day as weekday" do
      Hotel::WEEKDAY.each do |day|
        subject.weekday?(day).should be_true
      end

      Hotel::WEEKEND.each do |day|
        subject.weekday?(day).should be_false
      end
    end
  end

  context "match user type" do
    it "match Regular is regular" do
      subject.regular?("Regular").should be_true
      subject.regular?("Rewards").should be_false
    end

    it "match Rewards is rewards" do
      subject.rewards?("Rewards").should be_true
      subject.rewards?("Regular").should be_false
    end
  end

end

