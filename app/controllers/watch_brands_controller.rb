require "nokogiri"
require "httparty"
require "byebug"

class WatchBrandsController < ApplicationController
  @@watchBrands = []
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
            @@watchBrands << singleWatch
          else
            nil
          end
        else
          singleWatch = {
            name: watch.attributes["title"].value,
            url: watch.attributes["href"].value
          }
          @@watchBrands << singleWatch
          # puts singleWatch[:name]
        end
      end
    end

  def index
    scrapeModelNames
    @watch_brands = @@watchBrands
    render json: @watch_brands
  end

end
