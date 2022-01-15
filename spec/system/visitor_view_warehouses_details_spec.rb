require 'rails_helper'

describe 'Visitor view warehouses details' do
  it 'from a link on home' do
    warehouses = []
    warehouse = Warehouse.new(id: 1, name: 'Juiz de Fora', code: 'JDF', description: 'Um galpão mineiro com o pé no Rio', address: 'Av Rio Branco', city: 'Juiz de Fora', state: 'MG', postal_code: '36000-000', total_area: '5000', useful_area: '3000')
    warehouses << warehouse
    warehouses << Warehouse.new(id: 1, name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade', address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL', postal_code: '57050-000', total_area: '10000', useful_area: '8000')
    allow(Warehouse).to receive(:all).and_return(warehouses)
    allow(Warehouse).to receive(:find).with(warehouse.id.to_s).and_return(warehouse)

    visit root_path
    click_on 'Juiz de Fora'
    
    expect(page).to have_content('Juiz de Fora')
    expect(page).to have_content('JDF')
    expect(page).to have_content('Descrição:')
    expect(page).to have_content('Um galpão mineiro com o pé no Rio')
    expect(page).to have_content('Endereço:')
    expect(page).to have_content('Av Rio Branco - Juiz de Fora/MG')
    expect(page).to have_content('CEP:')
    expect(page).to have_content('36000-000')
    expect(page).to have_content('Área Total:')
    expect(page).to have_content('5000 m2')
    expect(page).to have_content('Área Útil:')
    expect(page).to have_content('3000 m2')
  end

  it "and the warehouse doesn't exist" do
    warehouses = []
    warehouses << Warehouse.new(id: 1, name: 'Juiz de Fora', code: 'JDF', description: 'Um galpão mineiro com o pé no Rio', address: 'Av Rio Branco', city: 'Juiz de Fora', state: 'MG', postal_code: '36000-000', total_area: '5000', useful_area: '3000')
    warehouses << Warehouse.new(id: 1, name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade', address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL', postal_code: '57050-000', total_area: '10000', useful_area: '8000')
    allow(Warehouse).to receive(:all).and_return(warehouses)
    allow(Warehouse).to receive(:find).with('777').and_return(false)    

    visit warehouse_path(777)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão não existe'
  end

  it 'and render an error message if API is unavailable' do
    warehouses = []
    warehouses << Warehouse.new(id: 1, name: 'Juiz de Fora', code: 'JDF', description: 'Um galpão mineiro com o pé no Rio', address: 'Av Rio Branco', city: 'Juiz de Fora', state: 'MG', postal_code: '36000-000', total_area: '5000', useful_area: '3000')
    warehouses << Warehouse.new(id: 1, name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade', address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL', postal_code: '57050-000', total_area: '10000', useful_area: '8000')
    allow(Warehouse).to receive(:all).and_return(warehouses)
    allow(Warehouse).to receive(:find).with('1').and_return(nil)
     
    visit root_path
    click_on 'Juiz de Fora'
  
    expect(current_path).to eq root_path
    expect(page).to have_content('Não foi possível carregar dados do galpão no momento')
  end
end