require '../lib/key_holder.rb'
require '../lib/key_master.rb'

km = KeyMaster.new('./keyholders.yaml')
kh = KeyHolder.new(:name => "Someone", :password => "foobar", :email => "foo@bar.com", :expires_at => Time.now.to_i + 100*100*100)
3.times { kh.add_access }

km.key_holders << kh

kh = KeyHolder.new(:name => "Someone Else", :password => "foobazzle", :email => "foo@bar.com", :expires_at => Time.now.to_i + 100*100*100)
10.times { kh.add_access }

km.key_holders << kh

km.write
