require 'bundler'
Bundler::GemHelper.install_tasks
require "rake/testtask"

for adapter in %w( postgresql ) # UNTESTED - mysql sqlite oracle firebird sqlserver sqlserver_odbc db2 sybase openbase )
  Rake::TestTask.new("test_#{adapter}") { |t|
    t.libs << "test" << "test/connections/native_#{adapter}"
    t.pattern = "test/test_*.rb"
    t.verbose = true
  }
  task :default => :"test_#{adapter}"
end

SCHEMA_PATH = File.expand_path("../test/fixtures/db_definitions", __FILE__)
RUBYFORGE_PROJECT = "magicmodels"
GEM_NAME = "magic_multi_connections"

namespace :postgresql do
  desc 'Build the PostgreSQL test databases'
  task :build_databases do 
    sh %{ createdb "#{GEM_NAME}_unittest" }
    sh %{ psql "#{GEM_NAME}_unittest" -f #{File.join(SCHEMA_PATH, 'postgresql.sql')} }
    sh %{ createdb "#{GEM_NAME}_extra_unittest" }
    sh %{ psql "#{GEM_NAME}_extra_unittest" -f #{File.join(SCHEMA_PATH, 'postgresql.sql')} }
  end

  desc 'Drop the PostgreSQL test databases'
  task :drop_databases do 
    sh %{ dropdb "#{GEM_NAME}_unittest" }
    sh %{ dropdb "#{GEM_NAME}_extra_unittest" }
  end

  desc 'Rebuild the PostgreSQL test databases'
  task :rebuild_databases => [:drop_databases, :build_databases]
end

desc 'Build the PostgreSQL test databases'
task :build_postgresql_databases   => 'postgresql:build_databases'
task :drop_postgresql_databases    => 'postgresql:drop_databases'
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
