class WarehousesController < ApplicationController
  def show
    api_domain = Rails.configuration.apis["warehouse_api"]
    response = Faraday.get("#{api_domain}/api/v1/warehouses/#{params[:id]}")
    @warehouse = []
    if response.status == 200
      @warehouse = JSON.parse(response.body)
    else
      flash['alert'] = 'Não foi possível carregar dados do galpão no momento'
      redirect_to root_path
    end
  end
end