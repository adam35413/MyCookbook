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

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates(:name, :presence => true,
                   :length => {:maximum => 50 })
  validates(:email, :presence => true,
                    :uniqueness => true,
                    :format => {:with => email_regex})
  validates(:password, :presence => true,
                       :confirmation => true,
                       :lenght => {:within => 6..50})
end
