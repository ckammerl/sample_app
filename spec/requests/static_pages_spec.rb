#RSpec defines a domain-specific language (DSL) built just for testing:


require 'spec_helper'

describe "Static pages" do

    # the individual 'page variable' (Help, About, Contact, Home) is the 'subject' of the test; 
    subject { page } 
  

  # Using an RSpec 'shared example' command to eliminate test duplication
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }  # interpolation with individual 'let' commands
    it { should have_title(full_title(page_title)) }   # see spec/support/utilities.rb for 'full_title' method
  end


# RSpec: The first line indicates that we are describing the Home page. 
# This description is just a string, and it can be anything you want; 
  describe "Home page" do 
    before { visit root_path }  # use the 'before' method to visit the root_path BEFORE EACH example, ie: before each 'it' method:

    # eliminating some of the duplication by defining a 'heading' local variable with 'let'
    # let command creates 'local variable' with the given value on demand (ie when varialbe is used) <-> instance variable
      # instance variable is created upon assignment 
    # Then the spec says that when you visit the Home page at 'root_path', the content (heading) should contain the words “Sample App”;
      # the 'page title' is empty as the Home page (root) has no additional title, it's just localhost:3000/ 
    let(:heading)    { 'Sample App' }
    let(:page_title) { '' }


    # As with the first line, what goes inside the quote marks is IRRELEVANT to RSpec, 
      # and is intended to be descriptive to human readers.
    # 'it' method: because of 'subject { page }', the call to 'should' automatically uses the page variable supplied by Capybara
    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }
  end



  describe "Help page" do
    before { visit help_path } # use the 'before' method to visit the help_path before executing the 'it' method:

    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' } # localhost:3000/help

    it_should_behave_like "all static pages"
  end



  describe "About page" do
    before { visit about_path } 

    let(:heading)     { 'About' }
    let(:page_title)  { 'About'}

    it_should_behave_like "all static pages"
  end



  describe "Contact page" do
    before { visit contact_path }

  	let(:heading)     { 'Contact' }
    let(:page_title)  { 'Contact' }

    it_should_behave_like "all static pages"
  end


    # check that the links on the layout go to the right pages
    it "should have the right links on the layout" do

    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "sample app"
  end
end 