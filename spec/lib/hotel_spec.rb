require "spec_helper"
require 'hotel'

describe Hotel do

  subject do
    Hotel.new "Lakewood", 3, {
      "regular weekday" => 110,
      "regular weekend" => 90,
      "rewards weekday" => 80,
      "rewards weekend" => 80
    }
  end

  context "#price" do
    it "should get diff price depends on user and day" do
      subject.price({:user_type => "Regular", :day_of_week => "mon"}).should == 110
      subject.price({:user_type => "Regular", :day_of_week => "sun"}).should == 90
      subject.price({:user_type => "Rewards", :day_of_week => "sun"}).should == 80
      subject.price({:user_type => "Rewards", :day_of_week => "tues"}).should == 80
    end

    it "get nil with wrong input" do
      subject.price({:user_type => "Rards", :day_of_week => "tues"}).should be_nil
      subject.price({:user_type => "Rewards", :day_of_week => "ues"}).should be_nil
    end
  end

  context "basic attrs" do
    its(:name) { should == "Lakewood" }
    its(:rating) { should == 3 }
    its(:strategies) { should be_instance_of(Hash) }
    it { should respond_to(:price) }
  end

  context "#user_type" do
    it "get lower case of word" do
      subject.user_type("Regular").should == "regular"
      subject.user_type("Rewards").should == "rewards"
    end

    it "get nil if not in the USER_TYPE" do
      subject.user_type("Test").should be_nil
    end
  end

  context "#day_of_week" do
    it "get weekend if in WEEKEND" do
      Hotel::WEEKEND.each do |day|
        subject.day_of_week(day).should == 'weekend'
      end
    end
    it "get weekday if in WEEKDAY" do
      Hotel::WEEKDAY.each do |day|
        subject.day_of_week(day).should == 'weekday'
      end

    end
    it "else will be nil" do
      %w(adf afas cass).each do |day|
        subject.day_of_week(day).should be_nil
      end
    end
  end

end

