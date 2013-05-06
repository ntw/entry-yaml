require '../lib/key_master.rb'

km = KeyMaster.new
km.load

kh = KeyHolder.new
until kh.valid?
	print "Name: "
	kh.name = gets.chomp

	print "Email: "
	kh.email = gets.chomp

	print "Password: "
	kh.password = gets.chomp

	print "Expires at: "
	kh.expires_at = gets.chomp.to_i
end

km << kh
km.write
