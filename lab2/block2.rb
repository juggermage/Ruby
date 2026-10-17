# Завдання 4 і 5
# Спосіб 1 — оператори циклу (while / until) з обґрунтуванням вибору
# Спосіб 2 — ітератори (map, each_with_index, sort_by, each_cons, all?)


# Спосіб 1
def sorted_asc_while?(row)
  i = 0
  while i < row.size - 1
    return false if row[i] > row[i + 1]
    i += 1
  end
  true
end

def sorted_desc_while?(row)
  i = 0
  while i < row.size - 1
    return false if row[i] < row[i + 1]
    i += 1
  end
  true
end

def bubble_sort_while(row)
  a = row.dup
  swapped = true
  while swapped
    swapped = false
    i = 0
    while i < a.size - 1
      if a[i] > a[i + 1]
        a[i], a[i + 1] = a[i + 1], a[i]
        swapped = true
      end
      i += 1
    end
  end
  a
end

def shuffle_while(row)
  a = row.dup
  i = a.size - 1
  while i > 0
    j = rand(i + 1)
    a[i], a[j] = a[j], a[i]
    i -= 1
  end
  a
end

def task4_loop(matrix)
  result = []
  r = 0
  while r < matrix.size
    row = matrix[r]
    if sorted_asc_while?(row) || sorted_desc_while?(row)
      result << bubble_sort_while(row)
    else
      result << shuffle_while(row)
    end
    r += 1
  end
  result
end

# Спосіб 2
def task4_iterator(matrix)
  matrix.map do |row|
    asc  = row.each_cons(2).all? { |a, b| a <= b }
    desc = row.each_cons(2).all? { |a, b| a >= b }
    asc || desc ? row.sort : row.shuffle
  end
end


# Спосіб 1
def task5_loop(matrix)
  n = matrix.size
  # діагональ у ВИХІДНОМУ масиві: ключ рядка не змінюється при перестановках
  keys = []
  i = 0
  while i < n
    keys << matrix[i][i]
    i += 1
  end

  rows = matrix.map(&:dup)
  orig = (0...n).to_a   # початкові номери рядків — для стабільності при рівних ключах
  i = 0
  while i < n - 1
    min_idx = i
    j = i + 1
    while j < n
      if keys[j] < keys[min_idx] || (keys[j] == keys[min_idx] && orig[j] < orig[min_idx])
        min_idx = j
      end
      j += 1
    end
    if min_idx != i
      rows[i], rows[min_idx] = rows[min_idx], rows[i]
      keys[i], keys[min_idx] = keys[min_idx], keys[i]
      orig[i], orig[min_idx] = orig[min_idx], orig[i]
    end
    i += 1
  end
  rows
end

# ---- Спосіб 2: ітератор ----
def task5_iterator(matrix)
  matrix.each_with_index
        .sort_by { |row, i| [row[i], i] }   # [ключ, індекс] — стабільність
        .map(&:first)
end


def show(title, matrix)
  puts title
  matrix.each { |row| puts "  " + row.map { |x| x.to_s.rjust(3) }.join(" ") }
end

if __FILE__ == $PROGRAM_NAME
  m4 = [
    [1, 3, 5, 9],
    [9, 6, 2, 1],
    [4, 1, 7, 2],
    [2, 8, 3, 5]
  ]
  show("Завдання 4 — вихідна матриця:", m4)
  show("Завдання 4, спосіб 1 (while):", task4_loop(m4))
  show("Завдання 4, спосіб 2 (ітератор):", task4_iterator(m4))
  puts "(рядки 3 і 4 перемішуються випадково, тому способи можуть дати різний порядок)"
  puts

  m5 = [
    [ 7, 2, 1, 4],
    [ 3, 1, 9, 5],
    [ 6, 8, 4, 2],
    [ 5, 5, 5, 3]
  ]
  show("Завдання 5 — вихідна матриця:", m5)
  show("Завдання 5, спосіб 1 (while):", task5_loop(m5))
  show("Завдання 5, спосіб 2 (ітератор):", task5_iterator(m5))

end