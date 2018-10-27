require_relative 'json_reader'
require 'open-uri'
require 'nokogiri'
require 'json'

TOP500_URL = 'https://www.kinopoisk.ru/top/lists' \
              '/1/filtr/all/sort/order/page'.freeze

module KinopoiskReader
  def self.read_films_info(path_to_kinpoisk_json, update_json)
    parse_kinopoisk(path_to_kinpoisk_json) if update_json
    JsonReader.read_films_info(path_to_kinpoisk_json)
  end

  def self.parse_kinopoisk(path_to_output_json)
    films = []
    1.upto(20) do |page_num|
      url = "#{TOP500_URL}/#{page_num}/"

      begin
        html = URI.parse(url).open
      rescue SocketError
        raise 'Error: unable to connect to Kinopoisk'
      end

      doc = Nokogiri::HTML(html)

      html_news = doc.css('.news') # contains some unnecessary information
      html_films = html_news.first(html_news.size - 3)

      films += html_films.map do |html_film|
        title = html_film.at_css('.all').text.strip
        director = html_film.at_css('.lined').text.strip
        html_film_info = html_film.at_css('span').text.strip
        year = html_film_info.split('(')[1].split(')')[0]

        { title: title, director: director, release_year: year }
      end
    end

    File.write(path_to_output_json, JSON.pretty_generate(films: films))
  end
end
