require 'minitest/spec'
require 'minitest/autorun'
require '../lib/entry.rb'

describe KeyHolder, "a keyholder in our system" do

	before do
		@user = KeyHolder.new
	end

	it "can have a name" do
		@user.name = "Someone"
		@user.name.must_equal "Someone"
	end

	it "can have a password" do
		@user.password = "foobar"
		@user.password.must_equal "foobar"
	end

	it "can have an email" do
		@user.email = "foo@bar.com"
		@user.email.must_equal "foo@bar.com"
	end

	it "can have an expiration time" do
		time = Time.now.to_i
		@user.expires_at = time
		@user.expires_at.must_equal time
	end

	it "can accept attributes at initialization" do
		@user = KeyHolder.new(:name => "Someone", :password => "foobar",
				      :email => "foo@bar.com")
		@user.name.must_equal "Someone"
		@user.password.must_equal "foobar"
		@user.email.must_equal "foo@bar.com"
		@user.expires_at.wont_be_nil
	end
end
