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
params = { login: 'heriberto.perez@magmalabs.io'}

# simple acumulative dynamic query using AND
#

def available_email_login?
  true
end

def available_username_login?
  false
end

def available_first_name?
  true
end

base_query_string = ''

if available_email_login?
  base_query_string += "lower(email) = :value"
end

if available_username_login?
  base_query_string += ' OR ' if base_query_string.present?
  base_query_string += "username = :value"
end

if available_first_name?
  base_query_string += ' OR ' if base_query_string.present?
  base_query_string += "first_name = :value"
end

result = User.where(["#{base_query_string}", { value: params[:login] }])

puts result.to_sql
binding.pry
