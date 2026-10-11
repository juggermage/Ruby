students = [
  { student: "Іваненко", grade: 90 },
  { student: "Петренко", grade: 55 },
  { student: "Коваль",   grade: 60 },
  { student: "Шевченко", grade: 42 },
  { student: "Бондар",   grade: 78 },
  { student: "Мельник",  grade: 59 }
]

passed, failed = students.partition { |s| s[:grade] >= 60 }

puts "Склали (>= 60):"
passed.each { |s| puts "  #{s[:student]} - #{s[:grade]}" }

puts "Не склали (< 60):"
failed.each { |s| puts "  #{s[:student]} - #{s[:grade]}" }