$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'

module GemTools
  extend self

  def run(cmd)
    send(cmd.to_sym) rescue help
  end

  def help
    puts OPTS
  end

  def setup
    require 'fileutils'
    dest_file = File.join(ARGV[1], '/config/gems.yml')
    if File.exist?(dest_file) && ! OPTIONS.has_key?(:force)
      puts "#{dest_file} already exists.\n\ngemtools setup #{ARGV[1]} --force\n\nto overwrite"
      exit 1
    else
      FileUtils.copy(File.join(File.dirname(__FILE__), '../config/gems.template.yml'), dest_file)
      puts "#{dest_file} created"
    end
  end

  def install
    commands.each do |command|
      puts "\nrunning: #{command}"
      ret = system command
      # something bad happened, pass on the message
      p $? unless ret
    end
  end

  def dryrun
    puts "\n#{commands.join("\n")}\n\n"
  end

  def to_gemfile
    config = load_config

    if File.exist?('Gemfile')
      puts "GemFile already exists, not overwriting."
      exit 1
    end

    no_load = config['gems'].collect { |gem| gem if gem['load'] == false }.compact
    to_load = config['gems'].collect { |gem| gem unless gem['load'] == false }.compact

    File.open('Gemfile', 'w+') do |f|
      if config['source']
        f.puts "source #{config['source']}"
      else
        f.puts "source :gemcutter"
        f.puts "source 'http://gems.github.com/'"
      end

      f.puts ''

      to_load.each do |gem|
        f.puts bundler_gem_line(gem)
      end

      f.puts ''

      f.puts 'group :no_load do'
      no_load.each do |gem|
        f.puts '  ' + bundler_gem_line(gem)
      end
      f.puts 'end'
    end
  end

  def load_gems
    config = load_config
    unless config['gems'].nil?
      gems = config['gems'].reject {|gem_info| ! gem_info['load'] }
      gems.each do |gem_info|
        if defined?(gem)
          gem gem_info['name'], gem_info['version']
        else
          require_gem gem_info['name'], gem_info['version']
        end
        require gem_info['require_name'] || gem_info['name']
      end
    end
  end

  private

    def load_config
      require 'yaml'
      require 'erb'
      config_file = find_config
      unless config_file
        puts 'Could not find a gems.yml, checked . and ./config'
        exit 1
      end
      YAML.load(ERB.new(File.open(config_file).read).result)
    end

    def commands
      config = load_config
      gems = config['gems']
      commands = []

      unless gems.nil?
        docs = ''
        unless OPTIONS.has_key?(:docs) || RUBY_PLATFORM =~ /(mswin|mingw)/i
          docs << '--no-rdoc ' unless (`rdoc --version 2> /dev/null`).nil?
          docs << '--no-ri ' unless (`ri --version 2> /dev/null`).nil?
        end

        gem_command = config['gem_command'] || 'gem'
        gem_dash_y = "1.0" > Gem::RubyGemsVersion ? '-y' : ''

        gems.each do |gem|
          meets_reqs =

          # if forced
          # or the installed gems don't meet requirements
          if OPTIONS.has_key?(:force) || meets_requirements?(gem['name'], gem['version'])
            gem_config = gem['config'] ? " -- #{gem['config']}" : ''
            source = gem['source'] || config['source'] || nil
            source = "--source #{source}" if source
            cmd = "#{gem_command} install #{gem['path'] || gem['name']} -v #{gem['version']} #{gem_dash_y} #{source} #{docs} #{gem_config}"
            commands << cmd
          else
            puts "#{gem['name']} #{gem['version']} already installed"
          end
        end
      end
      commands
    end

    def find_config
      %w( . config ).each do |dir|
        config_file = File.join(dir, 'gems.yml')
        return config_file if File.exist?(config_file)
      end
      nil
    end

    def meets_requirements?(name, version)
      @specs ||= Gem::SourceIndex.from_installed_gems
      @specs.find_name(name, Gem::Requirement.new(version)).empty?
    end

    def check_updates
      config = load_config
      gems = config['gems']

      gems.each do |gem|
        source = gem['source'] || config['source'] || nil
        source = "--source #{source}" if source
        # puts "Checking #{gem['name']}"
        out = `gem list -r #{gem['name']} #{source}`
        ver = out.match(/\(([0-9\.]+)/)[1] #rescue 0
        puts "#{gem['name']} #{ver} is available, #{gem['version']} installed" if ver > gem['version']
      end
    end

    def bundler_gem_line(gem)
      line = "gem '#{gem['name']}', '#{gem['version']}'"
      line += ", :require => '#{gem['require_name']}'" if gem['require_name']
      line
    end
end
