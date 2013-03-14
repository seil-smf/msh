require 'test_helper'

class CacheTest < Test::Unit::TestCase
  def setup
    $conf = {
      :proxy_addr        => "proxy.example.jp",
      :proxy_port        => "8080",
      :domain            => "server.example.jp",
      :path              => "/public-api/v1",
      :access_key        => "xxxxxxxxxxxxxx",
      :access_key_secret => "yyyyyyyyyyyyyyyyy",
      :user_code         => "tsa99999999",
    }
  end

  def test_cache
    assert(Msh::Cache)
  end

  def test_cache_with_results_key
    response_json = {
      "results" => [
                    {
                      "code" => "tsw00000000",
                      "id" => "1",
                    },
                    {
                      "code" => "tsw00000000",
                      "id" => "3",
                    }
                   ]
    }.to_json

    response = mock()
    response.stubs(:body).returns(response_json)

    client = mock()
    client.stubs(:start).returns(response)
    Msh::SacmApiClient.stubs(:new).returns(client)

    cache = Msh::Cache.new
  end

end
