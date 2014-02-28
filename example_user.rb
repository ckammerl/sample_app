class User
	# create attribute accessors corresponding to a user’s name and email address. 
	# This creates “getter” and “setter” methods that allow us to retrieve (get) and 
	# assign (set) @name and @email instance variables
  attr_accessor :name, :email 

  def initialize(attributes = {})
    @name  = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end
end