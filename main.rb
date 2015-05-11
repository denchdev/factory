require_relative 'factory'

User = Factory.new :name, :age do
	public
	def say
		puts "Hi all, I am #{self.name}"
	 end
end

user = User.new "Den", "15"
otherUser = User.new "Den", "15"
puts user
puts user.name
puts user.age
puts user[1]
user.age = 35
puts user.age
user.say
puts "*" * 30
puts user
puts user.hash
puts user == otherUser
user[:age] = "26"
puts user
puts user.hash

