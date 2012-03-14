# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "elfproef/version"

Gem::Specification.new do |s|
  s.name        = "elfproef"
  s.version     = Elfproef::VERSION
  s.authors     = ["Sytze Loor", "Ariejan de Vroom"]
  s.email       = ["sytze@tweedledum.nl", "ariejan@ariejan.net"]
  s.homepage    = "https://github.com/sytzeloor/elfproef"
  s.summary     = %q{Validation for Dutch bank account numbers and Citizen Service Numbers (BSN)}
  s.description = %q{Validation for Dutch bank account numbers and Citizen Service Numbers (BSN)}

  s.rubyforge_project = "elfproef"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"

  s.add_dependency "activemodel"

end
