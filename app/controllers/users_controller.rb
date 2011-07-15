class UsersController < ApplicationController
  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    # Check if user exists
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to Calling This Home Cookbook!"
      redirect_to @user
    else
      @user.password = ""
      @user.password_confirmation = ""
      @title = "Sign up"
      render 'new'
    end
    # if not, creat user
  end

  def show
    if (params[:id].nil?)
      redirect_to signup_path
    else
      @user = User.find(params[:id])
      @title = "Profile"
    end
  end


end
