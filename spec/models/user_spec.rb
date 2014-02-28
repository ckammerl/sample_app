require 'spec_helper'

describe User do

			# initialization hash of attributes a user should have/ respond_to
  before { @user = User.new(name: "Example User", email: "user@example.com",
  							password: "foobar", password_confirmation: "foobar") }  

  subject { @user }

	# these tests do ensure that the constructions user.name and user.email etc are valid
	# whereas the 'before' block only tests the attributes when passed as a hash to 'new'
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }	#verifying that the subject (@user) is initially valid (=> true/false);
  							# 'be_valid' is the corresponding test method to the '.valid?' bolean method (see models/user.rb)

  # if subject { @user } would not have been defined above, the test method would be as follows:
  	# it "should be valid" do
  		# expect(@user).to be_valid
 	# end 

  describe "when name is not present" do # this test uses.. 

    before { @user.name = " " } #... the before block to set the user’s name to an invalid (blank) value and then ...

    it { should_not be_valid } #... checks that the resulting user object is not valid
  end

  describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when name is too long" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid }
  end 

  describe "when email format is invalid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address| 
        	@user.email = invalid_address
        	expect(@user).not_to be_valid
        end 
  	end 
  end 

  describe "when email format is valid" do
  	it"should be valid" do
  		# check the common valid email forms (uppercase, underscores, compound domains .org/.com, two-letter top-level domain jp (Japan)
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
  			@user_email = valid_address
  			expect(@user).to be_valid
  		end 
  	end 
  end 

   describe "when email address is already taken" do
    before do

    # make a user with the same email address as @user by using @user.dup, which 
    # creates a duplicate user with the same attributes
      user_with_same_email = @user.dup  

      user_with_same_email.email = @user.email.upcase  # test for the rejection of duplicate email addresses, insensitive to case

    # Since we then save that user, the original @user has 
    # an email address that already exists in the database, and hence should not be valid.  
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  # test: password presence validation
  describe "when password is not present" do
  	before { @user = User.new( name: "Example User", email: "user@example.com",
                     password: " ", password_confirmation: " ") }
  	it { should_not be_valid }
  end 

  # test: testing password mismatch
  describe "when password doesn't match confirmation" do
  	before { @user.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end 

  # test: password lenght validation
  	describe "with a password that's too short" do
  		before { @user.password = @user.password_confirmation = "a" * 5 }
  		it { should be_invalid }
	end

  # test: user authentification via email (because email is the user name/sign in name)
  describe "return value of authenticate method" do
  	before { @user.save }
  	# 'let' memoizes its value which means that it remembers the value from one invocation to the next
  		# here: because let memoizes the found_user variable, the find_by method will only be called once 
  		# whenever the User model specs are run
  	let(:found_user) { User.find_by(email: @user.email) }  # let creates a local variable which is equal to result of find_by


  	# as let memoizes its value, the first nested describe block invokes let to retrieve the user from the database using find_by,
  	# but the second describe block doesn’t hit the database a second time
  	describe "with valid password" do
  		it { should eq found_user.authenticate(@user.password) } # @user == found_user (ie password match)
  	end 

  	describe "with invalid password" do
  		let(:user_for_invalid_password) { found_user.authenticate("invalid") }

  		it { should_not eq user_for_invalid_password }
  		specify { expect(user_for_invalid_password).to be_false } # specify method = just a synonym for 'it', and can be used when writing 'it' would sound unnatural
  	end 
end 
end 