class RemoteInventory
  class << self
    attr_accessor :host, :api_version, :max_concurrency

    def max_concurrency
      @max_concurrency ||= 1
    end

    def api_version
      @api_version ||= '1'
    end

    def find_by_city_id(city_id)
      RemoteInventory.host = 'http://inventory-service-development.herokuapp.com'

      raise "RemoteInventory.host needs to be set" unless host
      JSON.parse(Typhoeus.get("#{host}/api/v#{api_version}/inventory_items/in_city/#{city_id}.json").body).map do |item|
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
