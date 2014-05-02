unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require_relative 'helper'

class TestCIFClient < Test::Unit::TestCase
  def test_perform_a_query_and_receive_results
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
    assert_not_nil(results)
    puts results
  end
end