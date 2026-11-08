# encoding: utf-8
# Лабораторна №5, варіант 16: Транспортні квитки

# Модуль (підключається через include)
module Registrable
  def register
    @registered = true
    "Квиток зареєстровано"
  end

  def registered?
    @registered == true
  end
end

class Ticket
  include Registrable
  attr_accessor :passenger, :price

  def initialize(passenger, price)
    @passenger = passenger
    @price = price
  end

  def verify
    !@passenger.empty? && @price > 0
  end

  def info
    "#{self.class}: #{@passenger}, #{@price} грн"
  end

  private

  def secret_code
    "X#{@price}"
  end
end

class AirTicket < Ticket
  def initialize(passenger, price, flight)
    super(passenger, price)
    @flight = flight
  end

  def verify
    super && @flight.start_with?("PS")
  end

  def register
    super + " (рейс #{@flight}, онлайн-реєстрація)"
  end
end

class RailTicket < Ticket
  def initialize(passenger, price, car)
    super(passenger, price)
    @car = car
  end

  def verify
    super && (1..20).include?(@car)
  end
end

class BusTicket < Ticket
  def verify
    super && @price >= 100
  end
end

air  = AirTicket.new("Іваненко", 4500, "PS123")
rail = RailTicket.new("Петренко", 650, 25)
bus  = BusTicket.new("Сидоренко", 300)

[air, rail, bus].each do |t|
  puts t.info
  puts "  verify: #{t.verify}"
  puts "  #{t.register}" if t.verify
end

bus.price = 350
puts "Нова ціна: #{bus.price}"

begin
  air.secret_code
rescue NoMethodError
  puts "secret_code - приватний, ззовні недоступний"
end

def rail.verify
  puts "  (синглтон) вагон виправлено"
  @car = 5
  super
end
puts "rail після синглтон-verify: #{rail.verify}"
puts "bus.verify (звичайний): #{bus.verify}"