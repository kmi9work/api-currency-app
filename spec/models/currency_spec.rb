require 'open-uri'
RSpec.describe Currency do
  it 'can update rates' do
    Currency.update_rates
    expect(Currency.exists?(name: "Доллар США")).to be true
    expect(Currency.exists?(name: "Евро")).to be true
    usd = Nokogiri::XML(URI.open(Currency::CURRENCY_URL)).xpath('//Valute[@ID="R01235"]')
    usd_rate = usd.search('Value').text.sub(',','.').to_f
    usd_name = usd.search('Name').text
    expect(Currency.find_by_name(usd_name).rate).to match(usd_rate)
  end
end