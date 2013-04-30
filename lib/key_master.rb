require '../lib/key_holder.rb'

class KeyMaster
	
	def initialize(options = {})
		@file_path = options[:file_path] || '../etc/keyholders.yaml'
		@key_holders = []
	end

	def load
		$/="\n\n"
		File.open(@file_path, "r").each do |object|
			  @key_holders << YAML::load(object)
		end
	end

	def write(file_path)
		File.open(@file_path, "w") do |file|
			@key_holder.each do |kh|
				if kh.valid?
					file.puts(kh)
					file.puts ""
				end
			end
		end
	end
end

