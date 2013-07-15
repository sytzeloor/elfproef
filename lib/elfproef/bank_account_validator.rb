require 'active_model/validator'
require 'active_support/concern'

# Validates if the specified value is a valid
# bank account number using the 11-test
class BankAccountValidator < ::ActiveModel::EachValidator
  extend ActiveSupport::Concern

  def validate_each(record, attribute, value)
    unless self.class.validate_account_number(value, options)
      record.errors.add(attribute, :invalid_bank_account, options)
    end
  end

  # Takes the bank account number and returns true if:
  #
  #  * The number is 1...7 digit ING account number (no verification is possible)
  #  * Is 9 or 10 digits and passes the 11-test
  #
  def self.validate_account_number(value, options = {})
    number = value.to_s.gsub(/\D/, '').strip
    # Not valid if length is 0, 8 or > 10
    return false if number.length == 0 || number.length == 8 || (value.length > 10 && value.length < 15) || value.length > 31

    # ING account numbers
    return true if (1..7).include?(number.length)

    # Validate length 9 and 10 numbers as bank accounts
    return true if self.validate_with_eleven_test(number) if (number.length == 9 || number.length == 10)

    # If all other validations are failing, we are possibly dealing with an IBAN number
    return true if self.validate_with_iban_test(value)

    return false
  end

  private

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
  def self.validate_with_eleven_test(number)
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

  # Perform the mod-97 test (as described in ISO 7064)
  # Check that the total IBAN length is correct as per the country. If not, the IBAN is invalid.
  # Move the four initial characters to the end of the string.
  # Replace each letter in the string with two digits, thereby expanding the string, where A = 10, B = 11, ..., Z = 35.
  # Interpret the string as a decimal integer and compute the remainder of that number on division by 97.
  #
  # If the remainder of the test equals 1, the IBAN is valid
  def self.validate_with_iban_test(value)
    country_prefix = to_ascii_code(value[0..3])
    bank_code = to_ascii_code(value[4..7])
    bank_number = value[8..value.length]
    ("#{bank_code}#{bank_number}#{country_prefix}".to_i % 97) == 1
  end

  def self.to_ascii_code(value)
    converted_value = ""
    value.each_byte do |byte|
      if (65..90).include?(byte)
        converted_value += (byte - 55).to_s
      else
        converted_value += byte.chr
      end
    end
    return converted_value
  end
end
