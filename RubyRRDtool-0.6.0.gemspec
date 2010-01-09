# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{auxesis-RubyRRDtool}
  s.version = "0.6.0"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["David Bacher", "Mark Probert"]
  s.cert_chain = nil
  s.date = %q{2010-01-09}
  s.description = %q{rubyrrdtool provides ruby bindings for RRD functions (via librrd), with functionality comparable to the native perl bindings. See examples/minmax.rb or the unit tests in the test directory for scripts that exercise the rrdtool functions.}
  s.email = %q{drbacher @nospam@ alum dot mit dot edu}
  s.extensions = ["extconf.rb"]
  s.files = ["README", "Manifest.txt", "Rakefile", "extconf.rb", "rrd_info.h", "rrdtool_main.c", "test/test_rrdtool.rb", "examples/function_test.rb", "examples/minmax.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://rubyforge.org/projects/rubyrrdtool/}
  s.require_paths = ["test"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{rubyrrdtool}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby language binding for RRD tool version 1.2+}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hoe>, [">= 1.1.1"])
    else
      s.add_dependency(%q<hoe>, [">= 1.1.1"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.1.1"])
  end
end
