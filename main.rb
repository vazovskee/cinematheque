require_relative 'lib/cinematheque'

current_path = Dir.pwd
films_dir = File.join(current_path, 'data', 'films')
cinematheque = Cinematheque.new_from_file(films_dir)

directors = cinematheque.directors_list

puts 'Программа «Фильм на вечер»'
directors.each_with_index { |director, index| puts "#{index + 1}) #{director}" }

puts "\nФильм какого режиссера вы хотите сегодня посмотреть?"
user_input = STDIN.gets.chomp

until user_input =~ /^[1-#{directors.size}]$/
  puts "\nВведите корректные данные"
  user_input = STDIN.gets.chomp
end
chosen_director = directors[user_input.to_i - 1]

puts "\nИ сегодня вечером рекомендую посмотреть:"
puts cinematheque.get_random_film_by_director(chosen_director)
