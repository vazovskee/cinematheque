require 'rspec'
require 'film'

describe 'Film' do
  it 'initializes film' do
    film = Film.new('Гражданин Кейн', 'Орсон Уэллс', '1941')
    correct_string = 'Орсон Уэллс - Гражданин Кейн (1941)'
    expect(film.to_s).to eq correct_string
  end

  it 'initializes film without args' do
    film = Film.new
    correct_string = '[режиссёр] - [название фильма] ([год выхода])'
    expect(film.to_s).to eq correct_string
  end
end
