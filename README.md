# Elfproef

[![Build Status](https://secure.travis-ci.org/sytzeloor/elfproef.png?branch=master)](http://travis-ci.org/sytzeloor/elfproef)

This gem adds two validators to your arsenal:

  * BsnValidator will validate Burgerservicenummers (Dutch social security numbers). It accepts both 8 and 9 digit BSN numbers.
  * BankAccountValidator will validate ING accounts (1-7 digits), and 9 or 10 digit bank account numbers using the elven-test.

## Installation

Install as a gem

	gem install elfproef

Or add it to your gemfile

	gem 'elfproef'

and run

	bundle install

## Usage

Using the BsnValidator

    class User < ActiveRecord::Base
      validates :bsn_number, bsn: true
    end

Using the BankAccountValidator

    class User < ActiveRecord::Base
      validates :account_number, bank_account: true
	end

You can also use these validators without `ActiveRecord` by including `ActiveModel::Validations`.
   
    class AwesomeDutchPerson
      include ActiveModel::Validations
      validates :bsn, bsn: true
    end

## I18n

Add the following to your locale file:

    en:
      activemodel:
        errors:
          models:
            YOUR_MODEL:
              attributes:
                ATTRIBUTE:
                  invalid_bank_account: "is not a valid bank account number"
                  invalid_bsn: "is not a valid BSN"

## Bugs / Feature Requests

Please post them to
[Github Issues](https://github.com/sytzeloor/elfproef/issues).

## Contributing

Feel free to help out. Fork the project, write your specs and code and
create a pull request.

## Contributors

  * Sytze Loor <sytze@tweedledum.nl> - original author
  * Ariejan de Vroom <ariejan@ariejan.net>

## License

Copyright (c) 2012 Sytze Loor

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
