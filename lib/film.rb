class Film
  def initialize(title = '[название фильма]',
                 director = '[режиссёр]',
                 release_year = '[год выхода]')
    @title = title
    @director = director
    @release_year = release_year
  end

  def to_s
    "#{@director} - #{@title} (#{@release_year})"
  end
end
