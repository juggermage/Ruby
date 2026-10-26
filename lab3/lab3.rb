# Завдання 1
dishes = {
  "Борщ" => 120,
  "Піца" => 250,
  "Вареники" => 150,
  "Салат Цезар" => 180,
  "Стейк" => 350,
  "Паста" => 220,
  "Суп" => 0,
  "Млинці" => 100,
  "Картопля фрі" => 90,
  "Компот" => nil
}

puts "Початкове меню:"
dishes.each { |name, price| puts "#{name}: #{price.nil? ? 'не задано' : price.to_s + ' грн'}" }

# Завдання 2
puts "\nЗавдання 2. Індексний масив:"
indexed_dishes = dishes.to_a
p indexed_dishes

# Завдання 3
puts "\nЗавдання 3. Сортування меню"
puts "1 - за назвою"
puts "2 - за ціною"

print "Виберіть опцію: "
option = gets.to_i

case option
when 1
  sorted_dishes = dishes.sort_by { |name, price| name }
  puts "\nМеню, відсортоване за назвою:"
  sorted_dishes.each { |name, price| puts "#{name}: #{price.nil? ? 'не задано' : price.to_s + ' грн'}" }
when 2
  sorted_dishes = dishes.sort_by { |name, price| [price.nil? ? Float::INFINITY : price, name] }
  puts "\nМеню, відсортоване за ціною:"
  sorted_dishes.each { |name, price| puts "#{name}: #{price.nil? ? 'не задано' : price.to_s + ' грн'}" }
else
  puts "Неправильний вибір!"
end

# Завдання 4
puts "\nЗавдання 4. Три страви з найкоротшими назвами:"
shortest_dishes = dishes.sort_by { |name, price| [name.length, name] }.first(3)
shortest_dishes.each { |name, price| puts "#{name}: #{price.nil? ? 'не задано' : price.to_s + ' грн'}" }

# Завдання 5
puts "\nЗавдання 5. П'ять найдешевших страв з ненульовою ціною:"
cheapest_dishes = dishes.select { |name, price| !price.nil? && price > 0 }
                        .sort_by { |name, price| price }
                        .first(5)
cheapest_dishes.each { |name, price| puts "#{name}: #{price} грн" }

# Завдання 6
puts "\nЗавдання 6. Пошук страви:"
print "Введіть назву страви: "
search_name = gets.chomp

if dishes.key?(search_name)
  puts "Страва '#{search_name}' є в меню."
  puts "Кількість у меню: 1"
else
  puts "Страви '#{search_name}' немає в меню."
  puts "Кількість у меню: 0"
end

# Завдання 7
puts "\nЗавдання 7. Загальна вартість меню:"
total = dishes.values.compact.sum
puts "Загальна вартість: #{total} грн"

# Завдання 8
puts "\nЗавдання 8. Перевірка цін:"
dishes.each do |name, price|
  if price.nil? || price == 0
    print "Введіть ціну страви '#{name}': "
    new_price = gets.to_f
    dishes[name] = new_price
  end
end

puts "\nМеню після оновлення цін:"
dishes.each { |name, price| puts "#{name}: #{price} грн" }
