class UsersController < ApplicationController
    def show
        user = User.find(params[:id])
        render json: user.to_json(
          include: [commands:
            {only: [:name]}
          ],
          except: [:created_at, :updated_at]
        )
    end
end
