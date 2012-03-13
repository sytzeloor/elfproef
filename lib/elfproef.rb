require "active_model"
require "active_model/validations"

# define my validator
class ElfproefValidator < ActiveModel::EachValidator
  # implement the method where the validation logic must reside
  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || "is not valid") unless Elfproef.elfproef(value)
  end
end


# Elfproef.
module Elfproef
  # Calculates the elfproef of a Dutch bank account number or Citizen Service Number (BSN).
  # Return value should be 0 (proof succeeded). Any other value means faillure.
  # Postbank bank accounts (7 digits) cannot be validated using the elfproef and
  # will always return 0 (success).
  # http://nl.wikipedia.org/wiki/Elfproef
  def self.elfproef(number)
    number, sum = number.to_s, 0
    number.gsub!(/\D/, '')                   # strip out any non-digit character.
    return true if number.length == 7        # always pass postbank accounts (7 digits)
    return false unless number =~ /^\d{9}$/  # account should be exactly 9 digits
    (1..9).each do |c|
      sum += number[-c].chr.to_i * c
    end
    sum % 11 == 0
  end
end