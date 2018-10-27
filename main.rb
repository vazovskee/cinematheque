require_relative 'lib/args_parser'
require_relative 'lib/cinematheque'

VERSION = '0.0.1'.freeze
KINOPOISK_JSON = File.join(__dir__, 'data',
                           'films_json', 'top500_kinpoisk.json').freeze

options = ArgsParser.parse(ARGV, VERSION)
cinematheque = Cinematheque.new_from_kinopoisk(KINOPOISK_JSON,
                                               update_json: options[:update])

directors = cinematheque.directors_list

puts 'Программа «Фильм на вечер»'
directors.each_with_index { |director, index| puts "#{index + 1}) #{director}" }

puts "\nФильм какого режиссера вы хотите сегодня посмотреть?"
user_input = STDIN.gets.to_i

until user_input.between?(1, directors.size)
  puts "\nВведите корректные данные"
  user_input = STDIN.gets.to_i
end
chosen_director = directors[user_input - 1]

puts "\nИ сегодня вечером рекомендую посмотреть:"
puts cinematheque.get_random_film_by_director(chosen_director)
