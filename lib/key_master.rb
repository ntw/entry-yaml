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
		$/="\n\n"
		File.open(@file_path, "r").each do |object|
			  @key_holders << YAML::load(object)
		end
	end

	def write
		File.open(@file_path, "w") do |file|
			@key_holders.each do |kh|
				if kh.valid?
					file.puts YAML::dump(kh)
					file.puts ""
				end
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
