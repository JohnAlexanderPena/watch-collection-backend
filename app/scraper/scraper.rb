require "nokogiri"
require "httparty"
require "byebug"

# class_variable_set(:@@watch_brands, x)

@@watch_brands = []
@@brand_watches = []
@@rolex_models = []
@@all_rolex_watches = []

def scrapeModelNames
  @@watch_brands = [] #reset for new search
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
          @@watch_brands << singleWatch
        else
          nil
        end
      else

        singleWatch = {
          # if watch.attributes["title"].value == "Oris"
          #   name: watch.attributes["title"].value.text,
          #   url: watch.attributes["href"].value
          # else
          name: watch.text,
          url: watch.values[0]
        }
      # end

        @@watch_brands << singleWatch
        # puts singleWatch[:name]
      end
    end
  end

  def showWatchModels

    @@brand_watches = [] #reset for new search
    brand = params[:model]
    # brand = "alpina"
    url = "https://www.tourneau.com/watches/brands/#{brand}/"
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
    @@rolex_models =[]
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
    @@rolex_models << watch
      end
    end
  end

  def get_rolex_details
    @@all_rolex_watches = []

    model =  params[:model]
    url = "https://www.tourneau.com/rolex/rolex-watches/#{model}/"
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
      @@all_rolex_watches << watch
      end
      # puts allWatches
  end
