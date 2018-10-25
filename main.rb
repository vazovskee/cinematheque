require_relative 'lib/cinematheque'

cinematheque = Cinematheque.new_from_kinopoisk(update_json: false)

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
