# Площадь треугольника. Площадь треугольника можно вычислить, 
# зная его основание (a) и высоту (h) по формуле: 1/2*a*h. 
# Программа должна запрашивать основание и высоту треугольника 
# и возвращать его площадь.

puts "Type triangle base"
triangle_base = gets.strip.to_f

puts "Type triangle height"
triangle_height = gets.strip.to_f

triangle_area = 0.5*triangle_base*triangle_height
puts "Triangle area = #{triangle_area.round(2)}"