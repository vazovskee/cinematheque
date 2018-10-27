require 'rspec'
require_relative '../lib/json_reader'

FIXTURES = File.join(__dir__, 'fixtures').freeze

describe 'FileReader' do
  describe '#read_film_info' do
    it 'reads one film info' do
      json_path = File.join(FIXTURES, 'json_files', 'single_film_info.json')
      film_info = JsonReader.read_films_info(json_path)
      expect(film_info).to eq [{ title: 'Гражданин Кейн',
                                 director: 'Орсон Уэллс',
                                 release_year: '1941' }]
    end

    it 'reads several films info' do
      json_path = File.join(FIXTURES, 'json_files', 'several_films_info.json')
      film_info = JsonReader.read_films_info(json_path)
      expect(film_info).to eq [{ title: 'Андрей Рублев',
                                 director: 'Андрей Тарковский',
                                 release_year: '1966' },
                               { title: 'Гражданин Кейн',
                                 director: 'Орсон Уэллс',
                                 release_year: '1941' },
                               { title: 'Про уродов и людей',
                                 director: 'Алексей Балабанов',
                                 release_year: '1998' },
                               { title: 'Зеркало',
                                 director: 'Андрей Тарковский',
                                 release_year: '1974' },
                               { title: 'Счастливые дни',
                                 director: 'Алексей Балабанов',
                                 release_year: '1991' }]
    end

    it 'tries to read from empty dir' do
      wrong_path = ''
      expect { JsonReader.read_films_info(wrong_path) }
        .to raise_error(RuntimeError,
                        'Error: json-file with films was not found')
    end
  end
end
