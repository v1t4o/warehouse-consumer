class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all
    if @warehouses.nil?
      flash.now['alert'] = 'Não foi possível carregar dados dos galpões'
    end
  end
end