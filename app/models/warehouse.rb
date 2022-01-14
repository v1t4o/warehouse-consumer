class Warehouse
  attr_accessor :id, :name, :code

  def initialize(id:, name:, code:, description:, address:, city:, state:, postal_code:, total_area:, useful_area:)
    @id = id
    @name = name
    @code = code
    @description = description
    @address = address
    @city = city
    @state = state
    @postal_code = postal_code 
    @total_area = total_area
    @useful_area = useful_area
  end

  def self.all
    api_domain = Rails.configuration.apis["warehouse_api"]
    response = Faraday.get("#{api_domain}/api/v1/warehouses")
    result = []
    if response.status == 200
      warehouses = JSON.parse(response.body)
      warehouses.each do |warehouse|
        result << Warehouse.new(id: warehouse["id"],name: warehouse["name"], code: warehouse["code"],  description: warehouse["description"], address: warehouse["address"], city: warehouse["city"], state: warehouse["state"], postal_code: warehouse["postal_code"], total_area: warehouse["total_area"], useful_area: warehouse["useful_area"])
      end
    else
      return nil
    end
    return result
  end
end