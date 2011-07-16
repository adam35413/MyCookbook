require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign in")
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @user = Factory(:user)
      @attr = {:email => @user.email, :password => @user.password}
    end

    describe "success" do

      it "should create a session when a valid user signs in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "should redirect to the show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end

    end

    describe "failure" do

      it "should not create a session with bad credentials" do
        @attr.merge(:email => "")
        post :create, :session => @attr
        controller.should_not be_signed_in
      end

    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      user = Factory(:user)
      test_sign_in(user)
    end

    it "should sign out a user" do
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end

  

end
