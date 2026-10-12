students = [
  { student: "Іваненко", grade: 90 },
  { student: "Петренко", grade: 55 },
  { student: "Коваль",   grade: 60 },
  { student: "Шевченко", grade: 42 },
  { student: "Бондар",   grade: 78 },
  { student: "Мельник",  grade: 59 }
]

# через partition
passed1, failed1 = students.partition { |s| s[:grade] >= 60 }

puts "Спосіб 1 (partition)"
puts "Склали (>= 60):"
passed1.each { |s| puts "  #{s[:student]} - #{s[:grade]}" }
puts "Не склали (< 60):"
failed1.each { |s| puts "  #{s[:student]} - #{s[:grade]}" }

puts

# через select і reject
passed2 = students.select { |s| s[:grade] >= 60 }
failed2 = students.reject { |s| s[:grade] >= 60 }

puts "Спосіб 2 (select + reject)"
puts "Склали (>= 60):"
passed2.each { |s| puts "  #{s[:student]} - #{s[:grade]}" }
puts "Не склали (< 60):"
failed2.each { |s| puts "  #{s[:student]} - #{s[:grade]}" }

puts
