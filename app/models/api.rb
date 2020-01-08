class Api < ApplicationRecord
    has_many :api_commands
    has_many :commands, through: :api_commands
end
