require File.dirname(__FILE__) + '/spec_helper'

describe BankAccountValidator do
  subject {
    Class.new do
      include ActiveModel::Validations
      attr_accessor :account
      validates :account, :bank_account => true
    end.new
  }

  let(:errors) { ["is not valid"] }

  it "accepts 1 digit ING accounts" do
    subject.account = "1"
    subject.should be_valid
  end

  it "accepts 2 digit ING accounts" do
    subject.account = "12"
    subject.should be_valid
  end

  it "accepts 3 digit ING accounts" do
    subject.account = "3"
    subject.should be_valid
  end

  it "accepts 4 digit ING accounts" do
    subject.account = "4"
    subject.should be_valid
  end

  it "accepts 5 digit ING accounts" do
    subject.account = "5"
    subject.should be_valid
  end

  it "accepts 6 digit ING accounts" do
    subject.account = "6"
    subject.should be_valid
  end

  it "accepts 7 digit ING accounts" do
    subject.account = "7"
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

  it "fails on an 8 digit number" do
    subject.account = "12345678"
    subject.should_not be_valid
    subject.errors[:account].should == errors
  end

  it "fails on obviously wrong numbers" do
    subject.account = "CHUCKNORRIS"
    subject.should_not be_valid
    subject.errors[:account].should == errors
  end

  it "fails on 1 digit errors" do
    subject.account = "133456789"
    subject.should_not be_valid
    subject.errors[:account].should == errors
  end
end
