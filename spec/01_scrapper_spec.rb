require_relative '../lib/01_scrapper'

describe 'la fonction lecture_page' do

  it 'scrape le nom des cryptos et la valeur correspondante sur la page coinmarketcap. renvoie une liste de hashes' do
    expect(check("Bitcoin")).to eq(to_f) 
  end

  it 'scrape le nom des cryptos et la valeur correspondante sur la page coinmarketcap. renvoie une liste de hashes' do
    expect(check("Ethereum")).to eq(to_f) 
  end

  it 'scrape le nom des cryptos et la valeur correspondante sur la page coinmarketcap. renvoie une liste de hashes' do
    expect(check("Binance Coin")).to eq(to_f) 
  end

  it 'scrape le nom des cryptos et la valeur correspondante sur la page coinmarketcap. renvoie une liste de hashes' do
    expect(check("Cardano")).to eq(to_f) 
  end

end
