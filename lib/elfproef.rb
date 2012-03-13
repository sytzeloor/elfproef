require "active_model"
require "active_model/validations"

# define my validator
class ElfproefValidator < ActiveModel::EachValidator
  # implement the method where the validation logic must reside
  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || "is not valid") unless Elfproef.elfproef(value, options)
  end
end


# Elfproef.
module Elfproef
  # Calculates the elfproef of a Dutch bank account number or Citizen Service Number (BSN).
  # Return value should be 0 (proof succeeded). Any other value means faillure.
  # Postbank bank accounts (7 digits) cannot be validated using the elfproef and
  # will always return 0 (success).
  # http://nl.wikipedia.org/wiki/Elfproef
  def self.elfproef(number, options = {})
    number, sum = number.to_s, 0
    number.gsub!(/\D/, '')                                                # strip out any non-digit character.
    return true if options[:allow_ing] && (1..7).include?(number.length)  # always pass ING accounts (between 1 and 7 digits)
    return false unless (9..10).include?(number.length)                   # account should be exactly 9 or 10 digits
    (1..number.length).each do |c|
      sum += number[-c].chr.to_i * c
    end
    sum % 11 == 0
  end
end
