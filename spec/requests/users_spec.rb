require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do

      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirm Password", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Mark"
          fill_in "Email",        :with => "mark@gmail.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirm Password", :with => "foobar"
          click_button
          response.should render_template('users/show')
          response.should have_selector("div.flash.success")

        end.should change(User, :count).by(1)
      end
    end
  end

  describe "sign in" do
    describe "success" do
      it "should sign in" do
        user = Factory(:user)
        visit signin_path
        fill_in "Email",        :with => user.email
        fill_in "Password",     :with => user.password
        click_button
        response.should render_template('users/show')
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
      
      it "success from home page" do
        user = Factory(:user)
        visit root_path
        click_link "Sign in"
        fill_in "Email",        :with => user.email
        fill_in "Password",     :with => user.password
        click_button
        response.should render_template('users/show')
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end


    describe "failure" do
      it "should not sign in" do
        visit signin_path
        fill_in "Email",        :with => "mark@gmail.com"
        fill_in "Password",     :with => "asdfasdf"
        click_button
        response.should render_template('sessions/new')
        controller.should_not be_signed_in
      end
    end
  end
end
