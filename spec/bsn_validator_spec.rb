require File.dirname(__FILE__) + '/spec_helper'

describe BsnValidator do
  subject {
    Class.new do
      include ActiveModel::Validations
      attr_accessor :number
      validates :number, :bsn => true
    end.new
  }

  let(:errors) { ["is not valid"] }

  it "accepts an 8 digit bsn" do
    subject.number = "12345672"
    subject.should be_valid
  end

  it "accepts a 9 digit bsn" do
    subject.number = "123456782"
    subject.should be_valid
  end

  it "rejects too short bsn numbers" do
    subject.number = "123"
    subject.should_not be_valid
    subject.errors[:number].should == errors
  end

  it "rejects too long bsn numbers" do
    subject.number = "123456789012345"
    subject.should_not be_valid
    subject.errors[:number].should == errors
  end

  it "rejects obvious incorrect bsn numbers" do
    subject.number = "NOTAXES"
    subject.should_not be_valid
    subject.errors[:number].should == errors
  end

  it "rejects mistyped bsn numbers" do
    subject.number = "123456789012345"
    subject.should_not be_valid
    subject.errors[:number].should == errors
  end
end
