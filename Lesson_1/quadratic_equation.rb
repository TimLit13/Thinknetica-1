# Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с. 
# Программа вычисляет дискриминант (D) и корни уравнения 
# (x1 и x2, если они есть) и выводит значения дискриминанта и корней 
# на экран. При этом возможны следующие варианты:
#   Если D > 0, то выводим дискриминант и 2 корня
#   Если D = 0, то выводим дискриминант и 1 корень (т.к. корни 
# в этом случае равны)
#   Если D < 0, то выводим дискриминант и сообщение "Корней нет"

puts "Программа для нахождения корней квадратного уравнения."
sleep 0.5
puts "Введите первый коэффициент a:"
a = gets.strip.to_f

puts "Введите второй коэффициент b:"
b = gets.strip.to_f

puts "Введите третий коэффициент c:"
c = gets.strip.to_f

if a == 0
  puts "Уравнение не является квадратным"
  exit
end


d = b**2 - 4*a*c

if d < 0
  puts "Дискриминант D = #{d.round(2)}, корни уравнения отсутствуют"
elsif d == 0
  puts "Дискриминант D = 0, у данного уравнения один корень: x = #{-b/(2*a)}"
else
  x_1 = (-b+Math.sqrt(d))/(2*a)
  x_2 = (-b-Math.sqrt(d))/(2*a)
  puts "Дискриминант D = #{d.round(2)}"
  puts "Корни уравнения: x1 = #{x_1.round(2)}, x2 = #{x_2.round(2)}"
end