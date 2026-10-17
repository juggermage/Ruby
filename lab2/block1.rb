# Завдання 6 і 7
# Спосіб 1 — керуючі конструкції (while / if / elsif)
# Спосіб 2 — ітератори (map, each_with_index, min)


# Спосіб 1
def task6_control(arr)
  result = arr.dup
  return result if arr.size < 3

  first = arr[0]
  last  = arr[-1]
  i = 1
  while i < arr.size - 1
    if arr[i].even?
      result[i] = arr[i] + first
    else
      result[i] = arr[i] + last
    end
    i += 1
  end
  result
end

# Спосіб 2
def task6_iterator(arr)
  first = arr.first
  last  = arr.last
  arr.each_with_index.map do |x, i|
    if i.zero? || i == arr.size - 1
      x
    else
      x.even? ? x + first : x + last
    end
  end
end


# Спосіб 1
def task7_control(arr)
  return [] if arr.empty?

  min = arr[0]
  i = 1
  while i < arr.size
    min = arr[i] if arr[i] < min
    i += 1
  end

  result = arr.dup
  i = 0
  while i < result.size
    result[i] = min if result[i] > 0
    i += 1
  end
  result
end

# Спосіб 2
def task7_iterator(arr)
  min = arr.min
  arr.map { |x| x > 0 ? min : x }
end


if __FILE__ == $PROGRAM_NAME
  a = [5, -3, 8, 2, -7, 10, 4, 9]
  puts "Вихідний масив: #{a.inspect}"
  puts
  puts "Завдання 6 (спосіб 1, керуючі конструкції): #{task6_control(a).inspect}"
  puts "Завдання 6 (спосіб 2, ітератор):            #{task6_iterator(a).inspect}"
  puts
  puts "Завдання 7 (спосіб 1, керуючі конструкції): #{task7_control(a).inspect}"
  puts "Завдання 7 (спосіб 2, ітератор):            #{task7_iterator(a).inspect}"

end