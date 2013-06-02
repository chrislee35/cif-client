# DESCRIPTION: queries collective-intelligence-framework sources
require 'json'
require 'net/http'
require 'net/https'
require 'digest/sha1'
require 'zlib'
require 'base64'
require 'openssl'

module CIF
	class Client
		attr_accessor :fields
		attr_writer :severity, :restriction, :fields
		def initialize(host,apikey,severity=nil,restriction=nil,nolog=false)
			@host = host
			@apikey = apikey
			@severity = severity
			@nolog = nolog
			@restriction = restriction
		end
		
		def query(q,severity=nil,restriction=nil,nolog=false)
			params = {'apikey' => @apikey}
			params['restriction'] = restriction || @restriction if restriction || @restriction
			params['severity'] = severity || @severity if severity || @severity
			params['nolog'] = 1 if nolog || @nolog
			s = "#{@host}/#{q}?"+params.map{|k,v| "#{k}=#{v}"}.join("&")
			url = URI.parse s
			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = (url.scheme == 'https')
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			http.verify_depth = 5
			request = Net::HTTP::Get.new(url.path+"?"+url.query)
			request.add_field("User-Agent", "Ruby/#{RUBY_VERSION} cif-client v#{CIF::Client::VERSION}")
			response = http.request(request)
			doc = response.body
			data = JSON.parse(doc)
			@response_code = data['status']
			if data['data'] and data['data']
				feed = data['data']['feed']
			end
			feed
		end
	end
end
