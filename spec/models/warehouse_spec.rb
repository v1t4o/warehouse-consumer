require 'rails_helper'

describe Warehouse do
  context '.all' do
    it 'should return all warehouses' do
      warehouses_data = File.read(Rails.root.join('spec','support','api_resources','warehouses.json'))
      response = Faraday::Response.new(status: 200, response_body: warehouses_data)
      allow(Faraday).to receive(:get).with('http://localhost:8000/api/v1/warehouses').and_return(response)

      result = Warehouse.all

      expect(result.length).to eq 2
      expect(result.first.name).to eq 'Juiz de Fora'
      expect(result.first.code).to eq 'JDF'
      expect(result.last.name).to eq 'Guarulhos'
      expect(result.last.code).to eq 'GRU'
    end

    it 'should return empty if theres no warehouse' do
      response = Faraday::Response.new(status: 200, response_body: '[]')
      allow(Faraday).to receive(:get).with('http://localhost:8000/api/v1/warehouses').and_return(response)

      result = Warehouse.all

      expect(result).to eq []
    end

    it 'should return nil if API is unavailable' do
      response = Faraday::Response.new(status: 500, response_body: '{}')
      allow(Faraday).to receive(:get).with('http://localhost:8000/api/v1/warehouses').and_return(response)

      result = Warehouse.all

      expect(result).to eq nil
    end    
  end

  context '.find(id)' do
    it 'should return a warehouse' do
      warehouse_data = File.read(Rails.root.join('spec','support','api_resources','warehouse.json'))
      response = Faraday::Response.new(status: 200, response_body: warehouse_data)
      allow(Faraday).to receive(:get).with('http://localhost:8000/api/v1/warehouses/1').and_return(response)

      result = Warehouse.find(1)

      expect(result.name).to eq 'Juiz de Fora'
      expect(result.code).to eq 'JDF'
    end
  end

  context '.save' do
    it 'create a warehouse and return a warehouse' do
      warehouse = Warehouse.new(name: 'Juiz de Fora', code: 'JDF', description: 'Um galpão mineiro com o pé no Rio', address: 'Av Rio Branco', city: 'Juiz de Fora', state: 'MG', postal_code: '36000-000', total_area: '5000', useful_area: '3000')
      warehouse_data = File.read(Rails.root.join('spec','support','api_resources','warehouse.json'))
      response = Faraday::Response.new(status: 201, response_body: warehouse_data)
      params = '{"name": "' + warehouse.name + '", "code": "' + warehouse.code + '", "description": "' + warehouse.description + '", "address": "' + warehouse.address + '", "city": "' + warehouse.city + '", "state": "' + warehouse.state + '", "postal_code": "' + warehouse.postal_code + '", "useful_area": "' + warehouse.useful_area + '", "total_area": "' + warehouse.total_area + '"}'
      headers = { "Content-Type" => "application/json" }
      allow(Faraday).to receive(:post).with('http://localhost:8000/api/v1/warehouses', params, headers).and_return(response)

      result = warehouse.save()

      expect(result.name).to eq 'Juiz de Fora'
      expect(result.code).to eq 'JDF'
      expect(result.description).to eq 'Um galpão mineiro com o pé no Rio'
      expect(result.address).to eq 'Av Rio Branco'
      expect(result.city).to eq 'Juiz de Fora'
      expect(result.state).to eq 'MG'
      expect(result.postal_code).to eq '36000-000'
      expect(result.total_area).to eq 5000
      expect(result.useful_area).to eq 3000
    end
  end
end