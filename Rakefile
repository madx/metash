require 'rubygems'
require 'rake'
require 'rake/gempackagetask'

METASH_GEMSPEC = eval(File.read('metash.gemspec'))

Rake::GemPackageTask.new(METASH_GEMSPEC) do |pkg|
  pkg.need_tar_bz2 = true
end
task :default => "pkg/#{METASH_GEMSPEC.name}-#{METASH_GEMSPEC.version}.gem" do
  puts "generated latest version"
end
