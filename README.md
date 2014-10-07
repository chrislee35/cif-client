# CIF::Client

This ruby module interfaces with the Collective Intelligence Framework (as a client) to display intrusion alerts pulled from various feeding systems.  For more information, please visit the CIF Google Project Hosting page.

https://code.google.com/p/collective-intelligence-framework/


## Installation

Add this line to your application's Gemfile:

    gem 'cif-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cif-client

## Usage

	require 'configparser'
	require 'cif/client'
	config = "#{ENV['HOME']}/.cif"
	severity = nil
	restriction = nil
	nolog = false

	config = ConfigParser.new(config)
	host = config['client']['host']
	apikey = config['client']['apikey']
	query = "64.120.146.250"
	client = CIF::Client.new(host,apikey,severity,restriction,nolog)
	results = client.query(query)
	puts results

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
