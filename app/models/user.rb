class User < ApplicationRecord
    has_many :user_commands
    has_many :commands, through: :user_commands
end
