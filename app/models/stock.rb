class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker_symbol, presence: true

  def self.new_lookup(ticker_symbol)
    begin
      compamy = Alphavantage::Fundamental.new(symbol: ticker_symbol)
      quote = Alphavantage::TimeSeries.new(symbol: ticker_symbol).quote
      new(ticker: ticker_symbol, name: compamy.overview[:name], last_price: quote[:price])
    rescue => exception
      return nil
    end
  end
end
