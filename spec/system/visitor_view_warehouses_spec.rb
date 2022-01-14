require 'rails_helper'

describe 'Visitor view warehouses' do
  it 'on home page' do
    warehouses = File.read(Rails.root.join('spec','support','api_resources','warehouses.json'))
    response = Faraday::Response.new(status: 200, response_body: warehouses)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(response)

    visit root_path

    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
    expect(page).to have_content 'Juiz de Fora'
    expect(page).to have_content 'JDF'
  end

  it 'and thres no warehouse' do
    response = Faraday::Response.new(status: 200, response_body: '[]')
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(response)
    visit root_path

    expect(page).to have_content 'Nenhum galpão cadastrado'
  end

  it 'and render an error message if API is unavailable' do
    response = Faraday::Response.new(status: 503, response_body: '{}')
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(response)

    visit root_path

    expect(page).to have_content('Não foi possível carregar dados dos galpões')
  end
end