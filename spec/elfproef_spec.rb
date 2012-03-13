require File.dirname(__FILE__) + '/spec_helper'

describe Elfproef do

  account_class = Class.new do
    include ActiveModel::Validations
    attr_accessor :account
    validates :account, :elfproef => true
  end

  # Nine digets are not allowed
  it "tests account format" do
    Elfproef.elfproef(123456).should == false
    Elfproef.elfproef(1234567890).should == false
    Elfproef.elfproef('12345678a').should == false
  end

  # Invalid accounts will a value greather then 0
  it "tests invalid accounts" do
    Elfproef.elfproef(999999999).should == false
    Elfproef.elfproef('99.99.99.999').should == false
    Elfproef.elfproef('99 99 99 999').should == false
  end

  # Valid accounts will return 0
  it "tests valid accounts" do
    Elfproef.elfproef(123456789).should == true
    Elfproef.elfproef('12.34.56.789').should == true
    Elfproef.elfproef('12 34 56 789').should == true
    Elfproef.elfproef(1234567).should == true
    Elfproef.elfproef('1234567').should == true
  end


  shared_examples_for "elfproef validations" do
    subject { account_class.new }

    it "fails when empty" do
      subject.should_not be_valid
      subject.errors[:account].should == errors
    end

    it "fails with an obviously wrong number" do
      subject.account = "666"
      subject.should_not be_valid
      subject.errors[:account].should == errors
    end

    it "passes with a ING number" do
      subject.account = "1234567"
      subject.should be_valid
    end

    it "passes with a valid bank number" do
      subject.account = "123456789"
      subject.should be_valid
    end

    it "fails with an wrong bank number" do
      subject.account = "999999999"
      subject.should_not be_valid
      subject.errors[:account].should == errors
    end

  end

  describe "English validations" do
    let!(:errors) { [ "is not valid"] }
    it_should_behave_like "elfproef validations"
  end
end