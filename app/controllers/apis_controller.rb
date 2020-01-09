class ApisController < ApplicationController
    
  def index
    apis = Api.all
    render json: apis.to_json()
  end

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
