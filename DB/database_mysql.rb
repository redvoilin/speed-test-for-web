require 'active_record'

DB = {
    :adapter => 'mysql2',
    :host => '192.168.61.128',
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