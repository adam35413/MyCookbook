class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create, :destroy]
  before_filter :correct_user, :only  => [:edit, :update]

  def new
    @title = "Sign up"
    @user = User.new
  end
  
  def edit
    @title = "Edit Profile"
  end
    
  def create
    # Check if user exists
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
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

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:error] = "Unable to update settings"
      @title = "Edit user"
      render 'edit'
    end
  end

  def show
    if (params[:id].nil?)
      redirect_to signup_path
    else
      @user = User.find(params[:id])
      @title = "Profile"
    end
  end

  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end


end
