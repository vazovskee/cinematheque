require 'rspec'
require 'txt_files_reader'

FIXTURES = File.join(Dir.pwd, 'spec', 'fixtures').freeze

describe 'FileReader' do
  describe '#read_film_info' do
    it 'reads one film info' do
      film_dir_path = File.join(FIXTURES, 'txt_files', 'single_film_info')
      film_info = TxtFilesReader.read_films_info(film_dir_path)
      expect(film_info).to eq [{ title: 'Гражданин Кейн',
                                 director: 'Орсон Уэллс',
                                 release_year: '1941' }]
    end

    it 'reads several films info' do
      films_dir_path = File.join(FIXTURES, 'txt_files', 'several_films_info')
      film_info = TxtFilesReader.read_films_info(films_dir_path)
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
      empty_dir = File.join(FIXTURES, 'txt_files', 'empty_dir')
      expect { TxtFilesReader.read_films_info(empty_dir) }
        .to raise_error(RuntimeError, 'Empty film directory')
    end
  end
end
