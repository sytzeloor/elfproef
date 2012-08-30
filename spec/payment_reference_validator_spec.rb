require File.dirname(__FILE__) + '/spec_helper'

class PaymentReferenceTest
  include ActiveModel::Validations
  attr_accessor :reference
  validates :reference, :payment_reference => true
end

describe PaymentReferenceValidator do
  subject {
    PaymentReferenceTest.new
  }

  it "accepts 7 digit payment references" do
    subject.reference = "1234567"
    subject.should be_valid
  end

  it "accepts 9 digit payment references" do
    subject.reference = "173456789"
    subject.should be_valid
  end

  it "accepts 10 digit payment references" do
    subject.reference = "5834567890"
    subject.should be_valid
  end

  it "accepts 11 digit payment references" do
    subject.reference = "79345678901"
    subject.should be_valid
  end

  it "accepts 12 digit payment references" do
    subject.reference = "603456789012"
    subject.should be_valid
  end

  it "accepts 13 digit payment references" do
    subject.reference = "2134567890123"
    subject.should be_valid
  end

  it "accepts 14 digit payment references" do
    subject.reference = "02345678901234"
    subject.should be_valid
  end

  it "accepts 16 digit payment references" do
    subject.reference = "5000056789012345"
    subject.should be_valid
  end

  it "rejects on an 6 payment references" do
    subject.reference = "123456"
    subject.should_not be_valid
    subject.errors[:reference].should be_present
  end

  it "rejects on an 8 payment references" do
    subject.reference = "12345678"
    subject.should_not be_valid
    subject.errors[:reference].should be_present
  end

  it "rejects on an 15 payment references" do
    subject.reference = "123456789012345"
    subject.should_not be_valid
    subject.errors[:reference].should be_present
  end

  it "rejects on obviously wrong numbers" do
    subject.reference = "CHUCKNORRIS"
    subject.should_not be_valid
    subject.errors[:reference].should be_present
  end
end
