require 'tiny_tds'
require 'activerecord-sqlserver-adapter'

DB = {
    :adapter => 'sqlserver',
    :host => '',
    :database => '',
    :username => '',
    :password => ''
}


def connect_to_DB
  ActiveRecord::Base.establish_connection(DB)
end

class MemberProfile < ActiveRecord::Base
  self.table_name = "MemberProfile"
  self.primary_key = "MemberID"
end

connect_to_DB

m = MemberProfile.first
puts m.Name