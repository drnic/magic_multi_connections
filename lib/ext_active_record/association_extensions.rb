#raise "STOP"

module ActiveRecord
  module Reflection
    
    # This will add the 'mirrors_owner_db_connection' property to
    # the Association Reflection object.
    class AssociationReflection
      
      def mirror_db_connection
        return :default unless self.options.key?(:mirror_db_connection)
        self.options.key?(:mirror_db_connection)
      end
    
      def mirror_db_connection=(value)
        self.options[:mirror_db_connection] = value
      end
      
    end
  end
  
  module Associations
    module ClassMethods
      
      def create_has_many_reflection(association_id, options, &extension)
          options.assert_valid_keys(
            :class_name, :table_name, :foreign_key,
            :exclusively_dependent, :dependent,
            :select, :conditions, :include, :order, :group, :limit, :offset,
            :as, :through, :source, :source_type,
            :uniq,
            :finder_sql, :counter_sql, 
            :before_add, :after_add, :before_remove, :after_remove, 
            :extend,
            :mirror_db_connection
          )

          options[:extend] = create_extension_module(association_id, extension) if block_given?

          create_reflection(:has_many, association_id, options, self)
        end

        def create_has_one_reflection(association_id, options)
          options.assert_valid_keys(
            :class_name, :foreign_key, :remote, :conditions, :order, :include, :dependent, :counter_cache, :extend, :as,
            :mirror_db_connection
          )

          create_reflection(:has_one, association_id, options, self)
        end

        def create_belongs_to_reflection(association_id, options)
          options.assert_valid_keys(
            :class_name, :foreign_key, :foreign_type, :remote, :conditions, :order, :include, :dependent, 
            :counter_cache, :extend, :polymorphic,
            :mirror_db_connection
          )
          
          reflection = create_reflection(:belongs_to, association_id, options, self)

          if options[:polymorphic]
            reflection.options[:foreign_type] ||= reflection.class_name.underscore + "_type"
          end

          reflection
        end
        
        def create_has_and_belongs_to_many_reflection(association_id, options, &extension)
          options.assert_valid_keys(
            :class_name, :table_name, :join_table, :foreign_key, :association_foreign_key, 
            :select, :conditions, :include, :order, :group, :limit, :offset,
            :uniq, 
            :finder_sql, :delete_sql, :insert_sql,
            :before_add, :after_add, :before_remove, :after_remove, 
            :extend,
            :mirror_db_connection
          )

          options[:extend] = create_extension_module(association_id, extension) if block_given?

          reflection = create_reflection(:has_and_belongs_to_many, association_id, options, self)

          reflection.options[:join_table] ||= join_table_name(undecorated_table_name(self.to_s), undecorated_table_name(reflection.class_name))
          
          reflection
        end
      
    end
  end
end
