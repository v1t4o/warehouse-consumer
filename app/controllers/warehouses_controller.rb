class WarehousesController < ApplicationController
  def show
    response = Faraday.get("http://localhost:3000/api/v1/warehouses/#{params[:id]}")
    @warehouse = []
    if response.status == 200
      @warehouse = JSON.parse(response.body)
      return
    end
    flash.now['alert'] = 'Não foi possível carregar dados do galpão'
  end
end