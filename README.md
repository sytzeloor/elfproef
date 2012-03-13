# Elfproef

This gem adds a validation method for Dutch bank account numbers and
Citizen Service Numbers (BSN). These can be validated using the
so-called Elfproef.

Based on:
[Elfproef](https://github.com/tilsammans/elfproef/) by tilsammans

## Installation

Install as a gem

	gem install elfproef

Or add it to your gemfile

	gem 'elfproef'

and run

	bundle install

## Usage

Simply add "validates_elfproef_of" to your model class.

	class User < ActiveRecord::Base
		validates :bank_account, elfproef: true
		validates :bsn, elfproef: true
	end

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