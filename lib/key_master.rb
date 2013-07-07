require '../lib/key_holder.rb'
require 'yaml'

class KeyMaster
	
	include Enumerable
	attr_accessor :file_path
	attr_accessor :key_holders

	def initialize(file_path = '../etc/keyholders.yaml')
		@file_path = file_path
		@key_holders = []
	end

	def load
		File.open(@file_path, "r")do |file|
			  @key_holders = YAML::load(file)
		end
	end

	def write
		if self.valid?
			File.open(@file_path, "w") do |file|
				file.puts YAML::dump(key_holders)
			end
		end
	end

	def name_present?(name)
		@key_holders.each do |kh|
			if kh.name == name
				return true
			end
		end
		false
	end

	def valid?
		@key_holders.all? {|kh| kh.valid?}
	end

	def each(&block)
		@key_holders.each(&block)
	end

	def <<(kh)
		@key_holders << kh
	end
end
