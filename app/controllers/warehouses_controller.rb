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

  def new
  end
  
  def create
    warehouse = Warehouse.new(name: params[:name],
                               code: params[:code],
                               description: params[:description],
                               address: params[:address],
                               state: params[:state],
                               city: params[:city],
                               postal_code: params[:postal_code],
                               useful_area: params[:useful_area],
                               total_area: params[:total_area]
                               )
    @warehouse = warehouse.save
    if @warehouse
      flash[:alert] = 'Galpão registrado com sucesso'
      return redirect_to warehouse_path(@warehouse.id)
    end
    flash.now[:alert] = 'Não foi possível criar o galpão'
    render 'new'
  end
end