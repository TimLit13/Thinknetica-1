# Заполнить массив числами фибоначчи до 100

fib = []
a, b = 0, 1

while a <= 100
  fib << a # fib.push(a)
  a, b = b, a + b
end

puts fib.inspect


# fib2 = [0, 1]
# i = 1
# sum = 1

# loop do
#   fib2[i+1] = fib2[i] + fib2[i-1]
#   i += 1
#   sum = fib2[i]+fib2[i-1]
#   break if sum >= 100
# end

# puts fib2.inspect