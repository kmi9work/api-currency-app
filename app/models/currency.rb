require 'open-uri'


class Currency < ApplicationRecord

  CURRENCY_URL = "http://www.cbr.ru/scripts/XML_daily.asp"

  def self.update_rates
    rates = Nokogiri::XML(URI.open(CURRENCY_URL)).xpath('//Valute').map do |n|
      name = n.search('Name').text
      rate = n.search('Value').text.sub(',','.').to_f
      currency = Currency.find_by_name(name)
      if currency
        currency.update({rate: rate})
      else
        Currency.create({name: name, rate: rate})
      end
    end
  end
end
