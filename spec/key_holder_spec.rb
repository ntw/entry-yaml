require 'minitest/spec'
require 'minitest/autorun'
require '../lib/key_holder.rb'

describe KeyHolder, "a keyholder in our system" do

	before do
		@user = KeyHolder.new(:name => "Someone", :password => "foobar",
				      :email => "foo@bar.com")
	end

	it "can have a name" do
		@user.name.must_equal "Someone"
	end

	it "can have a password" do
		@user.password.must_equal "foobar"
	end

	it "can have an email" do
		@user.email.must_equal "foo@bar.com"
	end

	it "can have an expiration time" do
		time = Time.now.to_i
		@user.expires_at = time
		@user.expires_at.must_equal time
	end

	it "can accept attributes at initialization" do
		@user.name.must_equal "Someone"
		@user.password.must_equal "foobar"
		@user.email.must_equal "foo@bar.com"
		@user.expires_at.wont_be_nil
	end

	it "can track uses of the key" do
		5.times do
			@user.add_access
		end
		@user.access_times.size.must_equal 5
	end

	it "can track the last use of the key" do
		@user.add_access
		assert_in_delta @user.access_times.last, Time.now.to_i, 10
	end

	it "is invalid if it has no name" do
		@user.name = nil
		@user.valid?.must_equal false
		@user.name = ""
		@user.valid?.must_equal false
	end

	it "is invalid if it has no password" do
		@user.password = nil
		@user.valid?.must_equal false
		@user.password = ""
		@user.valid?.must_equal false
	end

	it "is invalid if it never expires" do
		@user.expires_at = nil
		@user.valid?.must_equal false
	end

	it "can check if it is expired" do
		@user.expires_at = Time.now.to_i + 100
		@user.expired?.must_equal false
		@user.expires_at = Time.now.to_i - 100
		@user.expired?.must_equal true
	end
end
