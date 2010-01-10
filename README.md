Errand
======

Errand provides Ruby bindings for RRD functions (via librrd), and a clear
API for interacting with RRDs. 

Check under spec/ for usage examples. 

Using
=====

To set up an RRD to work with (whether it exists or otherwise): 

    @rrd = Errand.new(:filename => "data.rrd")

To create an RRD:

    @rrd.create(:sources => [
                  {:name => "Counter", :type => :counter, :heartbeat => 1800, :min => 0, :max => 4294967295}],
                :archives => [
                  {:function => :average, :xff => 0.5, :steps => 1, :rows => 2400}])

To update said RRD: 

    @rrd.update(:sources => [{:name => "Counter", :value => 1}]

To fetch that data: 

    @rrd.fetch # <= {:start => Time, :end => Time, 
                     :data => {"Counter" => [nil, nil, nil, 1]}

Dependencies
============

**Errand** requires RRDtool version 1.2 or later. Some RRD functions such
as rrddump are only available with the latest RRDtool.

Installation is standard. If you've installed the gem, you should be ready
to go. 

Otherwise, simply run:

    ruby extconf.rb
    make
    make install

This should build a library named `rrd.so` in the current directory. If it 
doesn't, please report bugs at [http://github.com/eric/rubyrrdtool/issues](http://github.com/eric/rubyrrdtool/issues)!

Building gem
============

gem build errand.gemspec 

Testing 
=======

Testing is done with RSpec. 

To run tests: 

   rake spec

To do
=====

* Documentation
* Build an interface that feels more ruby-like around this simple functional
  translation


License
=======

(the MIT license)

Copyright (c) 2006 

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
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
