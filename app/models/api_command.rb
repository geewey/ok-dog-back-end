class ApiCommand < ApplicationRecord
    belongs_to :api
    belongs_to :command
end
