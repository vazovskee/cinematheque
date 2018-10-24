require 'json'

module JsonReader
  def self.read_film_info(path_to_json)
    begin
      file = File.read(path_to_json, encoding: 'UTF-8')
    rescue SystemCallError
      abort 'Error: json-file with films was not found'
    end

    films_info = JSON.parse(file)['films']

    films_info.map do |film_info|
      film_params = {}
      film_params[:title] = film_info['title']
      film_params[:director] = film_info['director']
      film_params[:release_year] = film_info['release_year']

      film_params
    end
  end
end
