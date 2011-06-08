require 'yaml'
require 'json'
require 'net/http'

class WebServiceDocumentor
  class Service
    def initialize(base_uri, options)
      @base_uri = base_uri
      @endpoint = options["endpoint"]
      @params   = options["params"]
    end

    def to_s
      body = ""
      # TODO: respect HTTP Verb
      #       make use of params
      json_response = JSON.parse(Net::HTTP.get(URI.parse("http://#{@base_uri}#{@endpoint}")))

      body << @endpoint << "\n"

      if @params
        body << "Params: \n"

        @params.each do |key, value|
          body << "   #{key} \n"
          @params[key].each do |k,v|
            body << "    #{k}: #{v} \n"
          end
        end
      end

      body << "  response: \n"
      body << "    " << JSON.pretty_generate(json_response)
      body
    end
  end

  def self.generate(path_to_web_services)
    new.generate(path_to_web_services)
  end

  def generate(path_to_web_services)
    @yml_file     = YAML.load_file(path_to_web_services)
    @web_services = @yml_file["web_services"]
    @base_uri     = @yml_file["settings"]["base_uri"]

    curl_services
  end

private

  def curl_services
    body = ""

    @web_services.each do |web_service|
      service = Service.new(@base_uri, web_service)
      body << service.to_s
      body << " \n"
    end

    print body
  end
end

WebServiceDocumentor.generate("web_services.yml")
