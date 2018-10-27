require_relative 'film'
require_relative 'json_reader'
require_relative 'txt_files_reader'
require_relative 'kinopoisk_reader'

class Cinematheque
  def self.new_from_file(path_to_file, reader)
    new(reader.read_films_info(path_to_file))
  end

  def self.new_from_kinopoisk(path_to_kinpoisk_json, update_json: false)
    new(KinopoiskReader.read_films_info(path_to_kinpoisk_json, update_json))
  end

  def initialize(films_info)
    @film_catalog = organize_catalog(films_info)
  end

  def get_random_film_by_director(chosen_director)
    @film_catalog[chosen_director].sample
  end

  def directors_list
    @film_catalog.keys
  end

  private

  def organize_catalog(films_info)
    catalog = Hash.new { |hash, key| hash[key] = [] }
    films_info.each do |info|
      new_film = Film.new(info[:title], info[:director], info[:release_year])
      catalog[info[:director]] << new_film
    end
    catalog
  end
end
