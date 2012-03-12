require File.dirname(__FILE__) + '/spec_helper'

describe Elfproef do

  # Nine digets are not allowed
  it "tests account format" do
    Elfproef.elfproef(123456).should == false
    Elfproef.elfproef(1234567890).should == false
    Elfproef.elfproef('12345678a').should == false
  end

  # Invalid accounts will a value greather then 0
  it "tests invalid accounts" do
    Elfproef.elfproef(999999999).should == 9
    Elfproef.elfproef('99.99.99.999').should == 9
    Elfproef.elfproef('99 99 99 999').should == 9
  end

  # Valid accounts will return 0
  it "tests valid accounts" do
    Elfproef.elfproef(123456789).should == 0
    Elfproef.elfproef('12.34.56.789').should == 0
    Elfproef.elfproef('12 34 56 789').should == 0
    Elfproef.elfproef(1234567).should == 0
    Elfproef.elfproef('1234567').should == 0
  end
end