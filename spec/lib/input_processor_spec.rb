require "spec_helper"
require "input_processor"

class InputProcessor
  public :parse_day_in_week, :parse_user_type_and_dates, :dates_to_a
end

describe InputProcessor do
  subject { InputProcessor.new }

  let(:valid_input) { "Regular: 16Mar2009(mon), 17Mar2009(tues), 18Mar2009(wed)" }

  context "#parse" do
    it "should return and hash with user_type of string and days of string array" do
      result = subject.parse valid_input
      result[:user_type].should == "Regular"
      result[:days].should be_instance_of(Array)
      result[:days].should == ["mon", "tues", "wed"]
    end

    it "should be nil of days" do
      input = "Regular: 16Mar2009(mon), 17Mar2009(tues), 18Mar2009wed)"
      result = subject.parse input
      result[:user_type].should == "Regular"
      result[:days].should == ["mon", "tues", nil]
    end
  end

  context "parse_user_type_and_dates" do
    it "shoud have right result" do
      result = subject.parse_user_type_and_dates(valid_input)
      result[:user_type].should == "Regular"
      result[:dates].should == "16Mar2009(mon), 17Mar2009(tues), 18Mar2009(wed)"
    end

    it "should strip space" do
      space_input = "  Regular: 16Mar2009(mon), 17Mar2009(tues), 18Mar2009(wed) "
      result = subject.parse_user_type_and_dates space_input
      result[:user_type].should == "Regular"
      result[:dates].should == "16Mar2009(mon), 17Mar2009(tues), 18Mar2009(wed)"
    end

    it "should be nil with invalid input" do
      invalid_input = "aba asdfsd"
      result = subject.parse_user_type_and_dates invalid_input
      result.should be_nil
    end
  end

  context "dates_to_a" do
    it "get array if not nill" do
      subject.dates_to_a("16Mar2009(mon), 17Mar2009(tues)").should == ["16Mar2009(mon)", "17Mar2009(tues)"]
    end

    it "is nil if input is nil" do
      subject.dates_to_a(nil).should be_nil
    end
  end

  context "parse_day_in_week" do
    valid_input = "16Mar2009(mon)"
    invalid_input = "2123"

    it "should return mon" do
      subject.parse_day_in_week(valid_input).should == "mon"
    end

    it "should be nil with invalid input" do
      subject.parse_day_in_week(invalid_input).should be_nil
    end
  end

end
