require "rubygems"
require 'yaml'
require 'json'
require 'net/http'
require 'cgi'

class WebServiceDocumenter
  class Service
    def initialize(base_uri, options)
      @base_uri       = base_uri
      @endpoint       = options["endpoint"]
      @params         = options["params"]
      @method         = (options["method"] || "get").downcase
      @example_params = create_example_params
    end

    def to_s
      body = ""

      url = "http://#{@base_uri}#{@endpoint}"
      uri = URI.parse(url)

      result = if @method =~ /post/
        Net::HTTP.post_form(uri, @example_params)
      else
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.path)
        request.set_form_data(@example_params)

        request  = Net::HTTP::Get.new("#{uri.path}?#{request.body}")
        http.request(request)
      end

      if !result.kind_of?(Net::HTTPOK)
        raise "Couldn't perform request with url: #{url}"
      end

      json_response = JSON.parse(result.body)

      body << "\n"
      body << "==================================================\n"

      body << "URL: #{@endpoint} (#{@method.upcase})\n"
      body << "\n"

      body << "Request Params: \n"
      body << "\n"

      if @params && @params.any?
        @params.each do |key, value|
          body << "  #{key} \n"

          @params[key].each do |k,v|
            body << "    #{k}: #{v} \n"
          end
        end
      else
        body << "  None"
      end

      body << "\n"
      body << "Response: \n"
      body << "\n"
      body << JSON.pretty_generate(json_response)
      body << "\n"
      body << "\n"
      body
    end

  private

    def create_example_params
      hash = {}

      @params.each do |key, value|
        hash[key] = value["example_value"]
      end

      hash
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
