require File.dirname(__FILE__) + '/spec_helper'

class BankAccountTest
  include ActiveModel::Validations
  attr_accessor :account
  validates :account, :bank_account => true
end

describe BankAccountValidator do
  subject {
    BankAccountTest.new
  }

  it "accepts 1 digit ING accounts" do
    subject.account = "1"
    subject.should be_valid
  end

  it "accepts 2 digit ING accounts" do
    subject.account = "12"
    subject.should be_valid
  end

  it "accepts 3 digit ING accounts" do
    subject.account = "123"
    subject.should be_valid
  end

  it "accepts 4 digit ING accounts" do
    subject.account = "1234"
    subject.should be_valid
  end

  it "accepts 5 digit ING accounts" do
    subject.account = "12345"
    subject.should be_valid
  end

  it "accepts 6 digit ING accounts" do
    subject.account = "123456"
    subject.should be_valid
  end

  it "accepts 7 digit ING accounts" do
    subject.account = "1234567"
    subject.should be_valid
  end

  it "accepts P-prefixed ING accounts" do
    subject.account = "P123"
    subject.should be_valid
  end

  it "accepts P-prefixed ING accounts with 7 digits" do
    subject.account = "P1234567"
    subject.should be_valid
  end

  it "accepts a valid 9 digit bank account number" do
    subject.account = "123456789"
    subject.should be_valid
  end

  it "accepts a valid 10 digit bank account number" do
    subject.account = "0123456789"
    subject.should be_valid
  end

  it "rejects on an 8 digit number" do
    subject.account = "12345678"
    subject.should_not be_valid
    subject.errors[:account].should be_present
  end

  it "rejects on obviously wrong numbers" do
    subject.account = "CHUCKNORRIS"
    subject.should_not be_valid
    subject.errors[:account].should be_present
  end

  it "rejects on 1 digit errors" do
    subject.account = "133456789"
    subject.should_not be_valid
    subject.errors[:account].should be_present
  end
end
