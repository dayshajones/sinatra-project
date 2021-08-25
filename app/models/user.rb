class User < ActiveRecord::Base
    has_secure_password
    has_many :groceries
    validates :username, uniqueness: true
end
