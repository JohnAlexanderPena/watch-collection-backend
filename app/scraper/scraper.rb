require "nokogiri"
require "httparty"
require "byebug"

@watchBrands = []
@@brand_watches = []
@rolexModels = []
@allRolexWatches = []

def scrapeModelNames
  url = "https://www.tourneau.com/watches/brands/#all"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  names = parsed_page.css('div.brands-list').css('div.content-asset')
  allWatches = names.first.children.children.children
  allWatches.each do |watch|
      if watch.attributes.empty?
        nil
      elsif
        watch.attributes["title"].nil?
        nil
      elsif
        watch.attributes["href"].nil?
        nil
      elsif
        watch.attributes["href"].value[0..39] != "https://www.tourneau.com/watches/brands/"
          if watch.attributes["title"].value == "Rolex"
          singleWatch = {
            name: watch.attributes["title"].value,
            url: watch.attributes["href"].value
          }
          @watchBrands << singleWatch
        else
          nil
        end
      else
        singleWatch = {
          name: watch.attributes["title"].value,
          url: watch.attributes["href"].value
        }
        @watchBrands << singleWatch
        # puts singleWatch[:name]
      end
    end
  end

  def showWatchModels
     params = "Casio"
    url = 'https://www.tourneau.com/watches/brands/casio/'
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    watches = parsed_page.css('ul.search-result-items').css('li')
    watches.each do |watch|
        if watch.children.css('div.product-tile').empty?
          nil
        else
           watch = {
             model: watch.children.css('div.product-tile').css('div.product-image').children.children[1].values[1],
             image_url: watch.children.css('div.product-tile').css('div.product-image').children.children[1].values[0]
           }
           @@brand_watches << watch
      end
    end
  end

  def findRolexModels
    url = "https://www.tourneau.com/rolex/"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    rolexModel = parsed_page.css('div.content-asset').css('ul').css('ul').css('li.landing-watch')
    rolexModel.each do |model|
      
      if model.children.css('div.landing-image')[0].children.empty? && model.children.css('div.landing-image')[0].children[0].nil? && model.children.css('div.landing-image')[0].children[0].nil?
        nil
      else
      watch = {
        rolex_model: model.children.css('div.landing-image')[0].children[0].children[0].values.first,
        rolex_url: model.children.css('div.landing-image')[0].children[0].values,
        image_url: model.children.css('div.landing-image')[0].children[0].children[0].values.last
      }
    @rolexModels << watch
      end
    end
  end

  def get_rolex_details
    url = "https://www.tourneau.com/rolex/rolex-watches/day-date/"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page).css('div.primary-content')
    # watches = parsed_page.css('div.primary-content').css('div.search-result-content').css('li').children.children.children
    watches = parsed_page.css('div.primary-content').css('div.search-result-content').css('ul').css('li')

    watches.each do |watch|
      # byebug
      watch = {
        watch_url: watch.children[7].css('div.product-name').children.children[3].attributes["href"].value,
        description: watch.children[7].css('div.product-name').children.children[5].text,
        name: watch.children[7].css('div.product-image').children[2].children[1].attributes["title"].value,
        image_url: watch.children[7].css('div.product-image').children[2].children[1].attributes["src"].value
      }
      @allRolexWatches << watch
      end
      # puts allWatches
  end


get_rolex_details
scrapeModelNames
showWatchModels
findRolexModels

# puts "Brand WAtches"
# puts @@brand_watches
# puts "Watch Brands"
# puts @watchBrands
# puts @allRolexWatches
