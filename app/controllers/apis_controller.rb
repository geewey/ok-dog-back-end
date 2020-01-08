class ApisController < ApplicationController
    def show
        api = Api.find(params[:id])
        render json: api.to_json(
          include: [commands:
            {only: [:id, :name]}
          ],
          except: [:created_at, :updated_at]
        )
    end
end
