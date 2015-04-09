require 'active_record'

DB = {
    :adapter => 'mysql2',
    :host => 'localhost',
    :database => 'blog_development',
    :username => 'root',
    :password => ''
}

def connect_to_DB
  ActiveRecord::Base.establish_connection(DB)
end

class Article < ActiveRecord::Base
end

connect_to_DB