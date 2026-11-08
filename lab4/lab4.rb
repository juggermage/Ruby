puts "\n========== ЗАВДАННЯ 1 =========="

def sum(a, b = 0)
  a + b
end

puts "Сума двох чисел: #{sum(5, 10)}"
puts "Сума одного числа: #{sum(5)}"

def sum(a, b = 0, c = 0)
  a + b + c
end

puts "Сума трьох чисел: #{sum(5, 10, 15)}"


puts "\n========== ЗАВДАННЯ 2 =========="

def greet(name:, age: 18, city: "Івано-Франківськ")
  puts "Привіт, #{name}!"
  puts "Вік: #{age}"
  puts "Місто: #{city}"
end

greet(name: "Олена", age: 20, city: "Калуш")
greet(name: "Андрій")


puts "\n========== ЗАВДАННЯ 3 =========="

def adult?(age)
  age >= 18
end

def palindrome?(word)
  word.downcase == word.downcase.reverse
end

puts "Чи повнолітня людина? #{adult?(20)}"
puts "Чи є слово паліндромом? #{palindrome?("level")}"
puts "Чи є слово паліндромом? #{palindrome?("ruby")}"


puts "\n========== ЗАВДАННЯ 4 =========="

class Vector
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def +(other)
    Vector.new(@x + other.x, @y + other.y)
  end

  def *(number)
    Vector.new(@x * number, @y * number)
  end

  def ==(other)
    @x == other.x && @y == other.y
  end

  def x=(value)
    @x = value
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end

v1 = Vector.new(2, 3)
v2 = Vector.new(4, 5)

puts "Перший вектор: #{v1}"
puts "Другий вектор: #{v2}"
puts "Додавання векторів: #{v1 + v2}"
puts "Множення вектора на число: #{v1 * 2}"
puts "Порівняння векторів: #{v1 == v2}"

v1.x = 10
puts "Після зміни координати x: #{v1}"


puts "\n========== ЗАВДАННЯ 5 =========="

def sum_array(array)
  array.sum
end

def sum_splat(*numbers)
  numbers.sum
end

numbers = [1, 2, 3, 4, 5]

puts "Сума елементів масиву: #{sum_array(numbers)}"
puts "Сума чисел через *args: #{sum_splat(10, 20, 30)}"

result = numbers.inject(0) { |total, number| total + number }

puts "Сума через inject: #{result}"

a, b, *rest = [10, 20, 30, 40, 50]

puts "Перше число: #{a}"
puts "Друге число: #{b}"
puts "Решта чисел: #{rest}"


puts "\n========== ЗАВДАННЯ 6 =========="

def hello
  puts "Привіт!"
end

alias privit hello

hello
privit


puts "\n========== ЗАВДАННЯ 7 =========="

def run_block(name, &block)
  puts "Початок виконання блоку"
  block.call(name)
  puts "Кінець виконання блоку"
end

run_block("Руслан") do |name|
  puts "Привіт, #{name}!"
end


puts "\n========== ЗАВДАННЯ 8 =========="

def execute
  if block_given?
    puts "Блок передано"
    yield
  else
    puts "Блок не передано"
  end
end

def execute_with_argument
  puts "Виконання yield з аргументом:"
  yield("Руслан")
end

execute do
  puts "Виконується блок через yield"
end

execute

execute_with_argument do |name|
  puts "Привіт, #{name}!"
end


puts "\n========== ЗАВДАННЯ 9 =========="

my_proc1 = Proc.new do
  puts "Proc без аргументів"
end

my_proc2 = Proc.new do |name|
  puts "Привіт, #{name}!"
end

my_proc1.call
my_proc2.call("Діана")

puts "Клас об'єкта: #{my_proc2.class}"

my_proc2.call
my_proc2.call("Олена", "Андрій")

def proc_return
  my_proc = Proc.new do
    return "Вихід із методу через return у Proc"
  end

  my_proc.call

  puts "Цей рядок не виконається"
end

puts proc_return


puts "\n========== ЗАВДАННЯ 10 =========="

my_lambda1 = lambda do
  puts "Lambda без аргументів"
end

my_lambda2 = lambda do |name|
  puts "Вітаю, #{name}!"
end

my_lambda1.call
my_lambda2.call("Олена")

puts "Клас об'єкта: #{my_lambda2.class}"

begin
  my_lambda2.call("Андрій", "Руслан")
rescue ArgumentError => e
  puts "Помилка: #{e.message}"
end

def lambda_return
  my_lambda = lambda do
    return "Вихід із lambda"
  end

  puts my_lambda.call
  puts "Метод продовжує виконання"
end

lambda_return