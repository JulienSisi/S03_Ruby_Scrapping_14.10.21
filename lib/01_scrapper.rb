require 'pry'
require 'rubygems'
require 'nokogiri'  
require 'open-uri'
require 'rest-client'

def main_page_url_methode
  page = Nokogiri::HTML(RestClient.get("https://coinmarketcap.com/all/views/all/"))
  system "clear"
  return page
end


def scrapper_max
  scrapper_max_value = 20
  scrapper_max_value = scrapper_max_value.to_i
  return scrapper_max_value
end

#ticker_crypto = page.css('td.cmc-tablecell--sort-bysymbol').map{|ticker| ticker.text}
def symbol_scrapper_methode(scrapper_max_value, page)
scrapper_start = 1
array_symbol = Array.new
  loop do 
    if scrapper_start == scrapper_max_value
      break 
    else
      symbol_scrapper = scrapper_start
      #my_symbol_url = "/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[element_to_change]/td[3]/div"
      my_symbol_url = "/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[element_to_change]/td[2]/div/a[2]"
      symbol_scrapper = symbol_scrapper.to_s
      my_symbol_url_new = my_symbol_url.gsub("element_to_change", symbol_scrapper)
      symbol = page.xpath(my_symbol_url_new)
      symbol = symbol.text 
      array_symbol << symbol
      scrapper_start = scrapper_start+1
    end
  end
  #puts "#{array_symbol}"
  return array_symbol
end


def currency_scrapper_methode(scrapper_max_value, page)
scrapper_start = 1
array_currency = Array.new
loop do 
 if scrapper_start == scrapper_max_value
  break 
 else
  currency_scrapper = scrapper_start
  my_currency_url = "/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[element_to_change]/td[5]/div/a/text()"
  currency_scrapper = currency_scrapper.to_s
  my_currency_url_new = my_currency_url.gsub("element_to_change", currency_scrapper)
  currency = page.xpath(my_currency_url_new)
  currency = currency.text 
  array_currency << currency
  scrapper_start = scrapper_start+1
 end
end
#puts "#{array_currency}"
return array_currency
end


def crypto_hash_methode(array_symbol, array_currency)
  crypto_array = Array.new
  crypto_hash = Hash.new
  array_symbol.each_with_index do |array_symbol, index|
  crypto_hash[array_symbol] = array_currency[index]
  end
  crypto_array << crypto_hash
  #puts "cyptocurrencies : #{crypto_array}"
  crypto_array.each do |crypto_hash|
    puts "Cryptocurencies and their values :"
    crypto_hash.each do |key,value|
      puts (key.to_s + " : " + value.to_s)
    end
  end

end


def perform
  page = main_page_url_methode
  scrapper_max_value = scrapper_max
  array_symbol = symbol_scrapper_methode(scrapper_max_value, page)
  array_currency = currency_scrapper_methode(scrapper_max_value, page)
  crypto_hash_methode(array_symbol, array_currency)
end

perform

