require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "timekeeper"
    gem.summary = %Q{Timekeeper. Keeping track of your time.}
    gem.description = %Q{Timekeeper. Keeping track of your time.}
    gem.email = "koen@atog.be"
    gem.homepage = "http://github.com/atog/timekeeper"
    gem.authors = ["atog"]
    gem.add_development_dependency "thoughtbot-shoulda"
    gem.files = FileList['lib/**/*.rb']
    gem.test_files = []
    gem.add_dependency('fastercsv', '>= 1.5.0')
    gem.add_dependency('rufus-tokyo', '= 1.0.0')
    Jeweler::GemcutterTasks.new
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "timekeeper #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
