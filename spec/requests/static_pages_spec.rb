#RSpec uses the general malleability of Ruby to define a domain-specific language (DSL) built just for testing:


require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" } 
  # eliminating some of the duplication by defining a 'base_title' variable and using string interpolation below
  # Here only used for Sample App page, ie the 'root' test

   subject { page } 
   # the individual 'page variable' (Help, About, Contact) is the 'subject' of the test; 
   # NOT used for Sample App, ie 'root' test



# RSpec: The first line indicates that we are describing the Home page. 
# This description is just a string, and it can be anything you want; 
# Then the spec says that when you visit the Home page at 'root_path', the content should contain the words “Sample App”. 
# As with the first line, what goes inside the quote marks is IRRELEVANT to RSpec, and is intended to be descriptive to human readers. 
  describe "Home page" do 
    before { visit root_path }  # use the 'before' method to visit the root_path BEFORE EACH example, ie: before each 'it' method:

    it "should have the h1 'Sample App'" do
      expect(page).to have_content('Sample App')
    end

    it "should have the base title" do
      expect(page).to have_title("#{base_title}")
    end
  
   it "should not have a custom page title" do
      expect(page).not_to have_title('| Home')
    end
  end



  describe "Help page" do
    before { visit help_path } # use the 'before' method to visit the help_path BEFORE EACH example, ie: before each 'it' method:

    it { should have_content('Help') } # 'it' method shortened: Because of 'subject { page }', the call to 'should' automatically uses the page variable supplied by Capybara
    it { should have_title(full_title('Help')) } # see spec/support/utilities.rb for 'full_title' method
  end



  describe "About page" do
    before { visit about_path } 

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end



  describe "Contact page" do
    before { visit contact_path }

  	it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end 