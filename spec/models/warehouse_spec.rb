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
end