module TxtFilesReader
  def self.read_films_info(path_to_films)
    film_paths = Dir["#{path_to_films}/*.txt"]

    raise 'Empty film directory' if film_paths == []

    film_paths.map do |path_to_file|
      film_params = {}

      film_info = File.readlines(path_to_file, encoding: 'UTF-8', chomp: true)
      film_params[:title] = film_info[0]
      film_params[:director] = film_info[1]
      film_params[:release_year] = film_info[2]

      film_params
    end
  end
end
