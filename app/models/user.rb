class User < ActiveRecord::Base
    has_secure_password
    has_many :items
    validates :username, uniqueness: true
    validates :password, presence: true
   
end
