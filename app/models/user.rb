class User < ApplicationRecord
    has_secure_password # THIS WILL COMES WITH bcrypt
    has_many :records
end