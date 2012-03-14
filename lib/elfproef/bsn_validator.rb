require "active_model"
require "active_model/validations"

# Validates if the specified value is a valid
# Burgerservicenummer (Dutch social security number)
class BsnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || "is not valid") unless validate_bsn(value, options)
  end

  private

  # A BSN is an 8 or 9 digit Dutch social security
  # number.
  def validate_bsn(value, options = {})
    bsn = value.to_s.gsub(/\D/, '').strip

    # Only allow 8 or 9 digits
    return false if bsn.length < 8 || bsn.length > 9

    # Validate with the advanced eleven test
    validate_with_advanced_eleven_test(bsn)
  end

  # Performs the advanced 11-test on a
  # 8 or 9 digit account number
  #
  #  For 9 digits (prefix with a 0 for 8 digits):
  #
  #   123456782
  #   ABCDEFGHI
  #
  #   sum = 9*A + 8*B + 7*C + 6*D + 5*E + 4*F + 3*G + 2*H + -1*I
  #
  # Note the -1*I!
  #
  # If sum % 11 is 0, the number is valid, otherwise
  # a typo has been made or the number is outright invalid.
  def validate_with_advanced_eleven_test(number)
    # Make sure we have 9 digits
    number = "0#{number}" if number.size == 8

    numbers = number.split("").map(&:to_i).reverse

    sum = 0
    numbers.each_with_index do |digit, i|
      # The first digit is * -1, the rest
      # counts from 2 up.
      i = i == 0 ? -1 : i+1
      sum += digit * i
    end

    sum % 11 == 0
  end
end

