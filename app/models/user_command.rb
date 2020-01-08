class UserCommand < ApplicationRecord
    belongs_to :user
    belongs_to :command
end
