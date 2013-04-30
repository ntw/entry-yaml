class KeyHolder
	attr_accessor :name
	attr_accessor :password
	attr_accessor :email
	attr_accessor :expires_at
	attr_accessor :access_times

	def initialize(options = {})
		default_options = {
			:name => "",
			:password => "",
			:email => "",
			:expires_at => Time.now.to_i
		}
		options = default_options.merge(options)
		@name = options[:name]
		@password = options[:password]
		@email = options[:email]
		@expires_at = options[:expires_at]
	end

	def add_access
		@access_times ||= []
		@access_times.push Time.now.to_i
	end
end

