class KeyHolder
	attr_accessor :name
	attr_accessor :password
	attr_accessor :email
	attr_accessor :expires_at

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
end

