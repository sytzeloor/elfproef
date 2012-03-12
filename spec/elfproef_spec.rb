require File.dirname(__FILE__) + '/spec_helper'

describe Elfproef do

  # Nine digets are not allowed
  it "tests account format" do
    elfproef(123456).should == false
    elfproef(1234567890).should == false
    elfproef('12345678a').should == false
  end

  # Invalid accounts will a value greather then 0
  it "tests invalid accounts" do
    elfproef(999999999).should == 9
    elfproef('99.99.99.999').should == 9
    elfproef('99 99 99 999').should == 9
  end

  # Valid accounts will return 0
  it "tests valid accounts" do
    elfproef(123456789).should == 0
    elfproef('12.34.56.789').should == 0
    elfproef('12 34 56 789').should == 0
    elfproef(1234567).should == 0
    elfproef('1234567').should == 0
  end
end