require "active_model"
require "active_model/validations"

# Validates if the specified value is a valid
# bank account number using the 11-test
class BankAccountValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || "is not valid") unless validate_account_number(value, options)
  end

  private

  # Takes the bank account number and returns true if:
  #
  #  * The number is 1...7 digit ING account number (no verification is possible)
  #  * Is 9 or 10 digits and passes the 11-test
  #
  def validate_account_number(value, options = {})
    number = value.to_s.gsub(/\D/, '').strip

    # Not valid if length is 0, 8 or > 10
    return false if number.length == 0 || number.length == 8 || number.length > 10

    # ING account numbers
    return true if (1..7).include?(number.length)

    # Validate length 9 and 10 numbers as bank accounts
    validate_with_eleven_test(number)
  end

  # Performs the actual 11-test on a
  # 9 or 10 digit account number
  #
  #  For 10 digits (prefix with a 0 for 9 digits):
  #
  #   0123456789
  #   ABCDEFGHIJ
  #
  #   sum = 1*A + 2*B + 3*C + 4*D + 5*E + 6*F + 7*G + 8*H + 9*I + 10*J
  #
  # If sum % 11 is 0, the number is valid, otherwise
  # a typo has been made or the number is outright invalid.
  def validate_with_eleven_test(number)
    # Make sure we have a 10 digit account number,
    # Prefix with a 0 if necessary
    number = "0#{number}" if number.length == 9

    # Calculate the sum
    sum = 0
    number.split("").each_with_index do |char, i|
      sum += char.to_i * (i+1)
    end

    sum % 11 == 0
  end
end
