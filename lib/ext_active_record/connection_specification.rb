module ActiveRecord
  class Base

    class << self

      def active_connection_name #:nodoc:
        @active_connection_name ||=
          if active_connections[name] || @@defined_connections[name]
            name
          elsif self == ActiveRecord::Base
            nil
          elsif self.parent_module.ancestors.include?(MagicMultiConnection::Connected)
            self.parent_module.establish_connection_on self
            self.active_connection_name
          else
            superclass.active_connection_name
          end
      end

    end


  end
end
