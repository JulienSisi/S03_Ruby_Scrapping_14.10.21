require 'pry'
require 'rubygems'
require 'nokogiri'  
require 'open-uri'
require 'rest-client'


def main_page_url_methode
  page = Nokogiri::HTML(RestClient.get("http://annuaire-des-mairies.com/val-d-oise.html"))
  system "clear"
  return page
end


def find_web_pages(page)
  mail_adress_to_modify =  page.css('[class="lientxt"]/@href')
  mail_adress_array = Array.new
  mail_adress_array << mail_adress_to_modify
  mail_adress_array = mail_adress_array.flatten

  mail_adress_ready = Array.new
  mail_adress_array.each do |value|
    prefix = "http://annuaire-des-mairies.com"
    value = value.to_s
    mail_adress_ready << prefix + value.reverse.chop.reverse
  end
  return mail_adress_ready
end


def mail_adresses(mail_adress_ready)
  #puts mail_adress_ready
  puts "Loading, give it some time.."
  array_to_freedom = Array.new
  mail_adress_ready.each do |value|
    new_page = Nokogiri::HTML(RestClient.get(value))

    path_to_freedom = new_page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
    if path_to_freedom != nil
    array_to_freedom << path_to_freedom.text
    end
    puts array_to_freedom
  end
end
  

def perform
  page = main_page_url_methode
  mail_adress_ready = find_web_pages(page)
  mail_adresses(mail_adress_ready)
end 

perform