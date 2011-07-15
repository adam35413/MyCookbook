# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  encrypted_password :string(255)
#  profilePicture     :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe User do

  before(:each) do
    @attr = {:name => "Mike Lawrence",
             :email => "mlawrence@gmail.com",
             :password => "foobar",
             :password_confirmation => "foobar"}
  end

  it "should work with valid requirements" do
    User.create!(@attr)
  end

  it "should require a name" do
    @attr = @attr.merge(:name => "")
    no_user = User.new(@attr)
    no_user.should_not be_valid
  end
  
  it "should require a email" do
    @attr = @attr.merge(:email => "")
    no_email = User.new(@attr)
    no_email.should_not be_valid
  end

  it "should block names over 50 characters" do
    long_user = User.new(@attr.merge(:name => "a" * 51))
    long_user.should_not be_valid
  end

  it "should be a valid email address" do
    invalid_addresses = %w[blah.com 123123,come 2@gmail,com 13a asdfbbbbbbbbb.comuser@foo,com user_at_foo.org example.user@foo.]
    invalid_addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end

  end

  describe "password validation" do
    it "should require a password" do
      no_password = User.new(@attr.merge(:password => ""))
      no_password.should_not be_valid
    end

    it "should require password and confirm to be equal" do
      user = User.new(@attr.merge(:password => "asdaaaf"))
      user.should_not be_valid
    end
    
    it "should block password that are too short" do
      user = User.new(@attr.merge(:password => "asdf"))
      user.should_not be_valid
    end
    
    it "should block password that are too long" do
      user = User.new(@attr.merge(:password => "a" * 51))
      user.should_not be_valid
    end
  end

  describe "encrypted password validation" do
    before(:each) do
      @user = Factory(:user) 
    end

    it "should have an encrypted_password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should have a valid password" do
      User.authenticate(@user.email, "wrongpass").should be_nil
    end

    it "should have a password" do
      User.authenticate(@user.email, "").should be_nil
    end
    
    it "should return nil for no email" do
      User.authenticate("", "").should be_nil
    end
    
    it "should return a user for a valid combo" do
      User.authenticate(@user.email, @user.password).should_not be_nil
    end
  end

end
