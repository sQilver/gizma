class DotaMarketManager
  def update_status
    if !status_active? && Time.now.hour < 23 && Time.now.hour >= 7
      trade_on
    elsif status_active? && Time.now.hour >= 23
      trade_off
    end
  end

  def status_active?
    url = "https://market.dota2.net/api/Test/?key=#{ENV['DOTA_MARKET_SECRET_KEY']}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    my_hash = JSON.parse(response.body)
    my_hash['status']['site_online']
  rescue
    false
  end

  def trade_on
    url = "https://market.dota2.net/api/PingPong/?key=#{ENV['DOTA_MARKET_SECRET_KEY']}"
    uri = URI.parse(url)

    Net::HTTP.get_response(uri)
  end

  def trade_off
    url = "https://market.dota2.net/api/GoOffline/?key=#{ENV['DOTA_MARKET_SECRET_KEY']}"
    uri = URI.parse(url)

    Net::HTTP.get_response(uri)
  end
end
