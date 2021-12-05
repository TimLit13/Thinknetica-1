# Идеальный вес. Программа запрашивает у пользователя имя и рост и выводит
# идеальный вес по формуле (<рост> - 110) * 1.15, после чего выводит
# результат пользователю на экран с обращением по имени. Если идеальный 
# вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"

puts "Type your name:"
user_name = gets.strip.capitalize

puts "Type your height:"
user_height = gets.strip.to_i

ideal_weight = (user_height - 110)*1.15

if ideal_weight.negative?
	puts "Your weight is optimal"
else
	puts "#{user_name}, yor optimal weight is #{ideal_weight.round(0)}"
end