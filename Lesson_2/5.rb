# Заданы три числа, которые обозначают число, месяц, год 
# (запрашиваем у пользователя). Найти порядковый номер даты, 
# начиная отсчет с начала года. Учесть, что год может быть високосным. 
# (Запрещено использовать встроенные в ruby методы для этого вроде 
# Date#yday или Date#leap?) Алгоритм опредления високосного года:
# www.adm.yar.ru

year_hash = {
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31,
}

puts "Введите число"
user_day = gets.strip.to_i

puts "Введите месяц"
user_month= gets.strip.to_i

puts "Введите год"
user_year = gets.strip.to_i

# puts "Вы ввели: #{user_day}.#{user_month}.#{user_year}"

sum_days = 0
i = 1

while i <= (user_month-1)
  sum_days += year_hash[i] 
  i += 1 
end

sum_days += user_day

if (user_year % 4 == 0) && (user_year % 100 != 0)
  # puts "Високосный год!"
  if user_month.between?(1,2)
    puts "С начала #{user_year} года прошло #{sum_days} дней"
    exit
  end
  sum_days += 1
  puts "С начала #{user_year} года прошло #{sum_days} дней"
  exit
else
  puts "С начала #{user_year} года прошло #{sum_days} дней"
end