class Command < ApplicationRecord
    has_many :user_commands
    has_many :users, through: :user_commands
    has_many :api_commands
    has_many :apis, through: :api_commands

    
end
