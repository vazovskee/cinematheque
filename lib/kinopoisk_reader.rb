require_relative 'json_reader'
require 'open-uri'
require 'nokogiri'
require 'json'

TOP500_URL = 'https://www.kinopoisk.ru/top/lists' \
              '/1/filtr/all/sort/order/page'.freeze
KINOPOISK_JSON = File.join(Dir.pwd, 'data',
                           'films_json', 'top500_kinpoisk.json').freeze

module KinopoiskReader
  def self.read_films_info(path_to_kinpoisk_json = KINOPOISK_JSON, update_json)
    parse_kinopoisk(path_to_kinpoisk_json) if update_json
    JsonReader.read_films_info(path_to_kinpoisk_json)
  end

  def self.parse_kinopoisk(path_to_output_json = KINOPOISK_JSON)
    films = []
    1.upto(20) do |page_num|
      url = "#{TOP500_URL}/#{page_num}/"

      html = URI.parse(url).open

      doc = Nokogiri::HTML(html)

      html_news = doc.css('.news') # contains some unnecessary information
      html_films = html_news.first(html_news.size - 3)

      html_films.each do |html_film|
        title = html_film.at_css('.all').text.strip
        director = html_film.at_css('.lined').text.strip
        html_film_info = html_film.at_css('span').text.strip
        year = html_film_info.split('(')[1].split(')')[0]

        films << { title: title, director: director, release_year: year }
      end
    end

    file = File.new(path_to_output_json, 'w')
    file.puts JSON.pretty_generate(films: films)
    file.close
  end
end
