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

	it "can track uses of the key" do
		@user.access_times = []
		5.times do
			@user.add_access
		end
		@user.access_times.size.must_equal 5
	end

	it "can track the last use of the key" do
		@user.add_access
		assert_in_delta @user.access_times.last, Time.now.to_i, 10
	end
end
