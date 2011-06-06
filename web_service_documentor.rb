require "rubygems"
require 'yaml'
require 'json'
require 'net/http'

class WebServiceDocumentor

  def self.generate_documentation(path_to_web_services)
    yml_file     = YAML.load_file(path_to_web_services)
    web_services = yml_file["web_services"]
    base_uri     = yml_file["settings"]["base_uri"]
    params       = yml_file["params"]

    curl_services(web_services, base_uri)
  end

  # TODO: respect HTTP Verb
  #       make use of params

  def self.curl_services(web_services, base_uri)
    body = ""
    web_services.each do |web_service|
      json_response = JSON.parse(Net::HTTP.get(URI.parse("http://#{base_uri}#{web_service['endpoint']}")))

      body << web_service["endpoint"] << "\n"
      if web_service["params"]
        body << "Params: \n"

        web_service["params"].each do |key, value|
          body << "   #{key} \n"
          web_service["params"][key].each do |k,v|
            body << "    #{k}: #{v} \n"
          end
        end

      end
      body << "  response: \n"
      body << "    " << JSON.pretty_generate(json_response)
      body << " \n "
    end

    print body
  end


end

WebServiceDocumentor.generate_documentation("web_services.yml")

# [{"verb"=>"get", "params"=>{"api_token"=>{"required"=>true, "description"=>"The API token that you got in your confirmation email", "example_value"=>"abc123"}}, "endpoint"=>"/users/1.json"}]