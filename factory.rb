class Factory
	def self.new *variables, &block
		Class.new do
			variables.each {|var| attr_accessor var}

			define_method :initialize do |*values|
				values.each_with_index do |value, i|
					instance_variable_set("@#{variables[i]}", value)
				end
			end

			define_method :to_s do
				result = "#<"
				result << "#{self.class}" << " "
				variables.each_with_index do |var, i|
					result << "#{var}="
					result << instance_variable_get("@#{variables[i]}")
					result << ", "
				end
				result[result.length-2, result.length-1] = ">"
				result
			end

			define_method :[] do |arg|
				if arg.instance_of? Fixnum
					instance_variable_get("@#{variables[arg]}")
				else
					instance_variable_get("@#{arg}")
				end
			end

			define_method :[]= do |arg, value|
				if arg.instance_of? Fixnum
					instance_variable_set("@#{variables[arg]}", value)
				else
					instance_variable_set("@#{arg}", value)
				end
			end

			define_method :== do |other|
				return false unless self.class == other.class 
				variables.each do |var| 
					return false unless instance_variable_get("@#{var}") == other.instance_variable_get("@#{var}")
				end
				return true
			end

#			define_method :each do &block
#				variables.each do |var|
#					block.call(instance_variable_get("@#{var}"))
#				end
#			end

			define_method :hash do
				code = 17
				variables.each do |var|
					code = 37 * code + instance_variable_get("@#{var}").hash
				end
			code
			end

			define_method :eql? do |other|
				return false unless self.class == other.class
				self.hash == other.hash ? true : false
			end

			block.call if block_given?

		end
	end
end


