class RemoteInventory
  class << self
    attr_accessor :host, :api_version, :max_concurrency
    RemoteInventory.host = 'http://inventory-service-development.herokuapp.com'

    def max_concurrency
      @max_concurrency ||= 1
    end

    def api_version
      @api_version ||= '1'
    end

    def find_by_id(id)
      raise "RemoteInventory.host needs to be set" unless host
      Hashie::Mash.new JSON.parse(Typhoeus.get("#{host}/api/v#{api_version}/inventory_items/#{id}.json").body)
    end

    def find_by_city_id(city_id, limit: 3)
      raise "RemoteInventory.host needs to be set" unless host
      JSON.parse(Typhoeus.get("#{host}/api/v#{api_version}/inventory_items/in_city/#{city_id}.json?limit=#{limit}").body).map do |item|
        Hashie::Mash.new(item)
      end
    end

    def find_near_city_id(city_id, limit: 3)
      raise "RemoteInventory.host needs to be set" unless host
      JSON.parse(Typhoeus.get("#{host}/api/v#{api_version}/inventory_items/near_city/#{city_id}.json?limit=#{limit}").body).map do |item|
        Hashie::Mash.new(item)
      end
    end

    private
    def hydra
      @hydra ||= begin
        Typhoeus::Hydra.new(max_concurrency: max_concurrency)
      end
    end
  end
end
