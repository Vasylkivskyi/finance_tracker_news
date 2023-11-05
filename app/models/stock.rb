require 'rest-client'
require 'json'

class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker_symbol, presence: true

  def self.new_lookup(ticker_symbol)
    begin
      stock = get_stock_data(ticker_symbol)
      return nil if stock.nil?
      new(ticker: ticker_symbol, name: stock[:name], last_price: stock[:price])
    rescue => exception
      return nil
    end
  end

  private
  def self.get_stock_data(ticker)
    date = Time.now.strftime("%Y-%d-%m")
    response = RestClient.get("https://api.polygon.io/v2/aggs/ticker/#{ticker}/range/1/day/#{date}/#{date}?apiKey=#{Rails.application.credentials.poligonio[:access_key]}", {accept: :json})
    result = JSON.parse(response.body)
    if result["resultsCount"] == 0
      return nil
    else
      price = result["results"][0]["c"]
      second_response = RestClient.get("https://api.polygon.io/v3/reference/tickers/#{ticker}?apiKey=#{Rails.application.credentials.poligonio[:access_key]}", {accept: :json})
      second_result = JSON.parse(second_response.body)
      { name: second_result["results"]["name"], price: price }
    end
  end
end
