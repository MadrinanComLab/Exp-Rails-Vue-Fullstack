class User < ApplicationRecord
    has_secure_password # THIS WILL COMES WITH bcrypt
end