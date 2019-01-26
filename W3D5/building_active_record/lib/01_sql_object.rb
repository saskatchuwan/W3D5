require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    @query ||= DBConnection.execute2(<<-SQL)
                SELECT
                  *
                FROM
                  "#{self.table_name}"
                SQL
    
 
    @col_names = @query.first.map{|el| el.to_sym}
    
  end

  def self.finalize!
    columns.each do |col_name|
        define_method(col_name) do
          attributes[col_name]
        end

        define_method("#{col_name}=") do |val|
          attributes[col_name] = val
        end
    end
  end


  def self.table_name=(table_name)
    @table_name = "#{table_name}"
  end

  def self.table_name
    @table_name || "#{self}".tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name)
      self.send(attr_name, value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
