numbers = [3, 12, 15, 7, 21, 10, 11, 4, 33, 9, 14, 17]

result = numbers.select { |n| n.odd? && n > 10 }

puts "Початковий масив: #{numbers.inspect}"
puts "Непарні та більші за 10: #{result.inspect}"