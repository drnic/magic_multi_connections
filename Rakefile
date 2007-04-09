require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/contrib/rubyforgepublisher'
require 'fileutils'
require 'hoe'
include FileUtils
require File.join(File.dirname(__FILE__), 'lib', 'magic_multi_connections', 'version')

AUTHOR = "nicwilliams"  # can also be an array of Authors
EMAIL = "drnicwilliams@gmail.com"
DESCRIPTION = "Your ActiveRecord classes can be accessed within multiple modules, each which targets a different DB connection"
GEM_NAME = "magic_multi_connections" # what ppl will type to install your gem
RUBYFORGE_PROJECT = "magicmodels" # The unix name for your project
HOMEPATH = "http://#{RUBYFORGE_PROJECT}.rubyforge.org"


NAME = "magic_multi_connections"
REV = nil # UNCOMMENT IF REQUIRED: File.read(".svn/entries")[/committed-rev="(d+)"/, 1] rescue nil
VERS = ENV['VERSION'] || (MagicMultiConnection::VERSION::STRING + (REV ? ".#{REV}" : ""))
                          CLEAN.include ['**/.*.sw?', '*.gem', '.config']
RDOC_OPTS = ['--quiet', '--title', "magic_multi_connections documentation",
    "--opname", "index.html",
    "--line-numbers", 
    "--main", "README",
    "--inline-source"]

class Hoe
  def extra_deps 
    @extra_deps.reject { |x| Array(x).first == 'hoe' } 
  end 
end

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
hoe = Hoe.new(GEM_NAME, VERS) do |p|
  p.author = AUTHOR 
  p.description = DESCRIPTION
  p.email = EMAIL
  p.summary = DESCRIPTION
  p.url = HOMEPATH
  p.rubyforge_name = RUBYFORGE_PROJECT if RUBYFORGE_PROJECT
  p.test_globs = ["test/**/test_*.rb"]
  p.clean_globs = CLEAN  #An array of file patterns to delete on clean.
  
  # == Optional
  p.changes = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  #p.extra_deps     - An array of rubygem dependencies.
  #p.spec_extras    - A hash of extra values to set in the gemspec.
end

for adapter in %w( mysql sqlite oracle postgresql ) # UNTESTED - firebird sqlserver sqlserver_odbc db2 sybase openbase )
  Rake::TestTask.new("test_#{adapter}") { |t|
    t.libs << "test" << "test/connections/native_#{adapter}"
    t.pattern = "test/test_*.rb"
    t.verbose = true
  }
end

SCHEMA_PATH = File.join(File.dirname(__FILE__), *%w(test fixtures db_definitions))


desc 'Build the PostgreSQL test databases'
task :build_postgresql_databases do 
  sh %{ createdb "#{GEM_NAME}_unittest" }
  sh %{ psql "#{GEM_NAME}_unittest" -f #{File.join(SCHEMA_PATH, 'postgresql.sql')} }
  sh %{ createdb "#{GEM_NAME}_extra_unittest" }
  sh %{ psql "#{GEM_NAME}_extra_unittest" -f #{File.join(SCHEMA_PATH, 'postgresql.sql')} }
end

desc 'Drop the PostgreSQL test databases'
task :drop_postgresql_databases do 
  sh %{ dropdb "#{GEM_NAME}_unittest" }
  sh %{ dropdb "#{GEM_NAME}_extra_unittest" }
end

desc 'Rebuild the PostgreSQL test databases'
task :rebuild_postgresql_databases => [:drop_postgresql_databases, :build_postgresql_databases]


desc 'Generate website files'
task :website_generate do
  sh %{ ruby scripts/txt2html website/index.txt > website/index.html }
  sh %{ ruby scripts/txt2js website/version.txt > website/version.js }
  sh %{ ruby scripts/txt2js website/version-raw.txt > website/version-raw.js }
end

desc 'Upload website files to rubyforge'
task :website_upload do
  config = YAML.load(File.read(File.expand_path("~/.rubyforge/user-config.yml")))
  host = "#{config["username"]}@rubyforge.org"
  remote_dir = "/var/www/gforge-projects/#{RUBYFORGE_PROJECT}/#{GEM_NAME}/"
  local_dir = 'website'
  sh %{rsync -av --delete #{local_dir}/ #{host}:#{remote_dir}}
end

desc 'Generate and upload website files'
task :website => [:website_generate, :website_upload] do
end
