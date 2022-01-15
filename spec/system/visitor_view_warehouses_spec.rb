require 'rails_helper'

describe 'Visitor view warehouses' do
  it 'on home page' do
    warehouses = []
    warehouses << Warehouse.new(id: 1, name: 'Juiz de Fora', code: 'JDF', description: 'Um galpão mineiro com o pé no Rio', address: 'Av Rio Branco', city: 'Juiz de Fora', state: 'MG', postal_code: '36000-000', total_area: '5000', useful_area: '3000')
    warehouses << Warehouse.new(id: 1, name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade', address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL', postal_code: '57050-000', total_area: '10000', useful_area: '8000')
    allow(Warehouse).to receive(:all).and_return(warehouses)

    visit root_path

    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
    expect(page).to have_content 'Juiz de Fora'
    expect(page).to have_content 'JDF'
  end

  it 'and theres no warehouse' do
    allow(Warehouse).to receive(:all).and_return([])
    
    visit root_path

    expect(page).to have_content 'Nenhum galpão cadastrado'
  end

  it 'and render an error message if API is unavailable' do
    allow(Warehouse).to receive(:all).and_return(nil)

    visit root_path

    expect(page).to have_content('Não foi possível carregar dados dos galpões')
  end
end