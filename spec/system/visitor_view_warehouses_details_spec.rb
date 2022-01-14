require 'rails_helper'

describe 'Visitor view warehouses details' do
  it 'from a link on home' do
    warehouses = File.read(Rails.root.join('spec','support','api_resources','warehouses.json'))
    warehouse = File.read(Rails.root.join('spec','support','api_resources','warehouse.json'))
    response_warehouses = Faraday::Response.new(status: 200, response_body: warehouses)
    response_warehouse = Faraday::Response.new(status: 200, response_body: warehouse)
    allow(Faraday).to receive(:get).with("http://localhost:3000/api/v1/warehouses").and_return(response_warehouses)
    allow(Faraday).to receive(:get).with("http://localhost:3000/api/v1/warehouses/1").and_return(response_warehouse)
     
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
    response_warehouse = Faraday::Response.new(status: 200, response_body: '{}')
    allow(Faraday).to receive(:get).with("http://localhost:3000/api/v1/warehouses/777").and_return(response_warehouse)
     
    visit warehouse_path(777)

    expect(page).to have_content 'Galpão não encontrado'
  end

  it 'and render an error message if API is unavailable' do
    response = Faraday::Response.new(status: 503, response_body: '{}')
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/1').and_return(response)

    visit warehouse_path(1)

    expect(page).to have_content('Não foi possível carregar dados do galpão')
  end
end