require 'active_model/validator'
require 'active_support/concern'

# Validates if the specified value is a valid
# payment reference number using a weighted modulus 11
class PaymentReferenceValidator < ::ActiveModel::EachValidator
  extend ActiveSupport::Concern

  def validate_each(record, attribute, value)
    unless self.class.validate_payment_reference(value, options)
      record.errors.add(attribute, :invalid_payment_reference, options)
    end
  end

  # Takes the payment reference number and returns true if:
  #
  #  * The number is exact 7 digits (no verification is possible)
  #  * Is between 9 and 14 digits, has the correct check digit and has the correct length digit
  #  * Is exact 16 digits and has the correct check digit
  #
  def self.validate_payment_reference(value, options = {})
    number = value.to_s.gsub(/\D/, '').strip

    # Not valid if payment reference length is < 7, 8, 15 or > 16
    return false if number.length < 7 || number.length == 8 || number.length == 15 || number.length > 16

    # No further verification possible for 7 digit payment references
    return true if number.length == 7

    # For payment references between 9 and 14 digits validate it has the correct length digit
    self.validate_length_digit(number) if (9..14).include?(number.length)

    # Validate the check digit
    self.validate_check_digit(number)
  end

  private

  # Validates the length digit. This is the second digit when 
  # a payment reference is between 9 and 14 digits
  #
  # Possible values:
  #   7  for a  9-digit payment reference
  #   8  for a 10-digit payment reference
  #   9  for a 11-digit payment reference
  #   0  for a 12-digit payment reference
  #   1  for a 13-digit payment reference
  #   2  for a 14-digit payment reference
  #
  def self.validate_length_digit(number)
    number[1].chr.to_i == number.length - (number.length > 11 ? 12 : 2)
  end

  # Validates the check digit. This is the first digit when a payment
  # reference is between 9 and 14 digits or is exact 16 digits
  #
  # The check digit is calculated using a weighted modulus 11:
  #
  #   c123456789012345
  #    ABCDEFGHIJKLMNO
  #
  #   sum = 10*A + 5*B + 8*C + 4*D + 2*E + 1*F + 6*G + 3*H + 7*I + 9*J + 10*K + 5*L + 8*M + 4*N + 2*O
  #   c = 11 - (sum % 11)
  #
  # The check digit is equal to c, with two exceptions. The check digit is
  #   0 when c == 10
  #   1 when c == 11
  def self.validate_check_digit(number)
    # Remove the first digit (check digit) from the payment reference.
    # To calculate the sum we need a 15 digit payment reference, 
    # prefix with 0 if necessary.
    reference = number[1..-1].rjust(15,"0").split("")
    weights = [10,5,8,4,2,1,6,3,7,9,10,5,8,4,2]

    # Calculate the sum
    sum = 0
    i = 0
    while i < 15
      sum += reference[i].to_i * weights[i]
      i += 1
    end
    check_digit = 11 - (sum % 11)
    check_digit -= 10 if check_digit >= 10

    number[0].chr.to_i == check_digit
  end
end
