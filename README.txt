= GemTools

http://github.com/UnderpantsGnome/gem_tools-gem/wikis

== DESCRIPTION:

The gem verison of my lightweight tool to manage gems using a config file, 
similar to GemInstaller.

== FEATURES/PROBLEMS:

Doesn't yet work in Windows

== SYNOPSIS:

I use this to manage gem versions in my apps, it has a rake task to install gems 
and a load utility to load them on startup.

Install or update required gems
<pre><code>
gem_tools install
</pre></code>

Make sure they are loaded with the right versions during startup, by adding the 
following to your script or environment.rb (Rails)
<pre><code>
require 'gem_tools'
GemTools.load_gems
</pre></code>

The config file looks like
<pre><code>
# These are optional
source: http://local_mirror.example.com
gem_command: 'jruby -S gem'
gems:
  - name: mongrel
    version: "1.0"
    # this gem has a specfic source URL
    source: 'http://mongrel.rubyforge.org/releases'

  - name: hpricot_scrub
    version: '0.3.3'
    # this tells us to load not just install
    load: true 

  - name: postgres
    version: '0.7.1'
    load: true
    # any extra config that needs to be passed to gem install
    config: '--with-pgsql-include-dir=/usr/local/pgsql/include 
      --with-pgsql-lib-dir=/usr/local/pgsql/lib' 

  - name: rfeedparser_ictv
    version: '0.9.932'
    load: true
    # this one has a different load name than the gem name (not a normal need)
    require_name: 'rfeedparser'
</pre></code>

== REQUIREMENTS:

None

== INSTALL:

sudo gem install gem_tools

== TODO

* Write the tests/specs
* Make it work in Windows

== LICENSE:

(The MIT License)

Copyright (c) 2008 Michael Moen

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.