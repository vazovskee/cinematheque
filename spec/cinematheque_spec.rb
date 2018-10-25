require 'rspec'
require 'cinematheque'

FIXTURES = File.join(Dir.pwd, 'spec', 'fixtures').freeze

describe 'Cinematheque' do
  it 'initializes collection with one film' do
    film_dir_path = File.join(FIXTURES, 'txt_files', 'single_film_info')
    films = Cinematheque.new_from_file(film_dir_path, TxtFilesReader)
    expect(films.directors_list).to eq ['Орсон Уэллс']
    expect(films.get_random_film_by_director('Орсон Уэллс').to_s)
      .to eq 'Орсон Уэллс - Гражданин Кейн (1941)'
  end

  it 'initializes collection with several films' do
    films_dir_path = File.join(FIXTURES, 'txt_files', 'several_films_info')
    films = Cinematheque.new_from_file(films_dir_path, TxtFilesReader)
    expect(films.directors_list).to eq ['Андрей Тарковский',
                                        'Орсон Уэллс',
                                        'Алексей Балабанов']
  end

  it 'tries to initialize collection with no films_txt' do
    empty_dir = File.join(FIXTURES, 'empty_dir')
    expect { Cinematheque.new_from_file(empty_dir, TxtFilesReader) }
      .to raise_error(RuntimeError, 'Empty film directory')
  end
end
