require 'rails/generators'

module Oauth2FacebookGrantable
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../../templates', __FILE__)
    desc "Add facebook_identifier column to the 'User' model"

    # Commandline options can be defined here using Thor-like options:
    class_option :table_name, :type => :string, :default => "users", :desc => "User model name"

    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

    # Generator Code. Remember this is just suped-up Thor so methods are executed in order
    def copy_migrations
      @table_name = options[:table_name]
      migration_template "migration_add_column.rb", "db/migrate/add_facebook_identifier_to_#{@table_name}"
    end

    def self.next_migration_number(path)
       unless @prev_migration_nr
         @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
       else
         @prev_migration_nr += 1
       end
       @prev_migration_nr.to_s
     end

  end
end