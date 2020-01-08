class CommandsController < ApplicationController
    def show
        command = Command.find(params[:id])
        render json: command.to_json(
          include: [apis:
            {only: [:id, :name]}
          ],
          except: [:created_at, :updated_at]
        )
    end
end
