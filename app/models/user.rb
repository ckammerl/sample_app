class User < ActiveRecord::Base
	before_save { self.email = email.downcase }  # before_save is a callback method
  validates(:name,  { presence: true, length: { maximum: 50 }})

  # The application code for email format validation uses a regular expression (or regex) to 
  # define the format, along with the :format argument to the validates method
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i   # the Regex here is a constant (capital letter)
  validates(:email, presence: true, 
  			format: { with: VALID_EMAIL_REGEX }, 
  			uniqueness: { case_sensitive: false })

# has_secure_password gets the password tests (see model/user_spec.rb) to pass
	# Presence validations for the password and its confirmation are automatically added by has_secure_password
	# it also adds 'password' and 'password_confirmation' attributes,
	# requires the presence of the password, requires that they match, 
	# and adds an authenticate method to compare an encrypted password to the password_digest to authenticate users
		# Note: has_secure_password requires a 'password_digest' in your table
  has_secure_password
  validates(:password, { length: { minimum: 6 }})
end


# User.create(name: "John Doe").valid?   => true; this User will be saved into the db
# User.create(name: " ").valid? 		 => false; this User will not be saved into the db

# The following methods trigger validations, and will save the object to the database only if the object is valid:
	
	# create
	# create!
	# save
	# save!
	# update
	# update!

	# The bang versions (e.g. save!) raise an exception if the record is invalid. The non-bang versions don't;
	# save and update return false if the record is invalid;
	# create just returns the object 


# "errors.messages" instance method: 
	# After Active Record has performed validations, any errors found can be 
	# accessed through the errors.messages instance method, which returns a collection of errors. 
	# By definition, an object is valid if this collection is empty after running validations.

	# Note that an object instantiated with 'new' will not report errors even if 
	# it's technically invalid, because validations are not run when using new

	# Examples


=begin 
class Person < ActiveRecord::Base
  validates :name, presence: true
end

$ rails console: 
p = Person.new
=> #<Person id: nil, name: nil>
p.errors.messages
=> {}
 
p.valid?
=> false
p.errors.messages
=> {name:["can't be blank"]}
 
p = Person.create
=> #<Person id: nil, name: nil>
p.errors.messages
=> {name:["can't be blank"]}
=end 



# invalid? is simply the inverse of valid?. 
	# It triggers your validations, returning true if any errors were found in the object, and false otherwise



	# see http://guides.rubyonrails.org/active_record_validations.html


