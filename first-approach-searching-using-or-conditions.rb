require 'sqlite3'
require 'active_record'
require 'pry'

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'

# Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :email
    t.string :username
    t.string :first_name
    t.string :last_name
  end
end

# Define the models
class User < ActiveRecord::Base
end

User.create!(email: 'heriberto.perez@magmalabs.io', username: 'heridev', first_name: 'heriberto', last_name: 'perez')
User.create!(email: 'jhon@magmalabs.io', username: 'jhondoe', first_name: 'jhon', last_name: 'doe')
User.create!(email: 'juan.perez@magmalabs.io', username: 'juan', first_name: 'juan', last_name: 'perez')

# simple query
# mockup search query
#
params = { email: 'heriberto.perez@magmalabs.io', username: 'heridev', first_name: ''}

# simple acumulative dynamic query using AND
#
base_query_string = ''
search_fields = []

if params[:email].present?
  base_query_string += "email = ?"
  search_fields << params[:email]
end

if params[:username].present?
  base_query_string += ' OR ' if base_query_string.present?
  base_query_string += "username = ?"
  search_fields << params[:username]
end

if params[:first_name].present?
  base_query_string += ' OR ' if base_query_string.present?
  base_query_string += "first_name = ?"
  search_fields << params[:first_name]
end

if params[:last_name].present?
  base_query_string += ' OR ' if base_query_string.present?
  base_query_string += "last_name = ?"
  search_fields << params[:last_name]
end

result = User.where("#{base_query_string}", *search_fields)

puts result.to_sql
binding.pry
