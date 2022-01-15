class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
    if @warehouse.nil?
      flash['alert'] = 'Não foi possível carregar dados do galpão no momento'
      redirect_to root_path
    elsif !@warehouse
      flash['alert'] = 'Galpão não existe'
      redirect_to root_path
    end
  end
end