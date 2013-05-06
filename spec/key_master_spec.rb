require 'minitest/spec'
require 'minitest/autorun'
require '../lib/key_master.rb'

describe KeyMaster, "a key manager in our system" do

	before do 
		@km = KeyMaster.new './keyholders.yaml'
	end

	it "can accept a file_path at initialization" do
		@km = KeyMaster.new("./keyholders.yaml")
		@km.file_path.must_equal "./keyholders.yaml"
	end

	it "can load the default file_path if none is given" do
		@km = KeyMaster.new
		@km.file_path.must_equal '../etc/keyholders.yaml'
	end

	it "can read the keyholders from the file path" do
		@km.load
		@km.key_holders.first.name.must_equal 'Someone'
	end

	it "can load more than one keyholder from the file path" do
		@km.load
		@km.key_holders.size.must_equal 2
	end

	it "can check to see if a keyholder's name is already present" do
		@km.load
		@km.name_present?('Someone').must_equal true
	end

	it "can verify that its structure as a whole is valid" do
		@km.load
		@km.valid?.must_equal true

		@kh = KeyHolder.new
		@kh.name = ""
		@km << @kh
		@km.valid?.must_equal false
	end

	it "can be enumerated with each" do
		@km.load
		@km.all? {|kh| kh.valid?}
	end

end
