$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

unless defined?(ActiveSupport) && defined?(ActiveRecord)
  begin
    require 'active_support'  
    require 'active_record'  
  rescue LoadError
    require 'rubygems'
    require 'active_support'
    require 'active_record'  
  end
end

module MagicMultiConnection
end

require 'magic_multi_connections/version'
require 'magic_multi_connections/connected'
require 'magic_multi_connections/module'
require 'ext_active_record/connection_specification'