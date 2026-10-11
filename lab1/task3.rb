numbers = [5, 8, 12, -3, 7, -9, 1]

index1 = numbers.find_index { |n| n < 0 }
puts "Спосіб 1 (find_index): #{index1.inspect}"

index2 = nil
numbers.each_with_index do |n, i|
  if n < 0
    index2 = i
    break
  end
end
puts "Спосіб 2 (each_with_index + break): #{index2.inspect}"