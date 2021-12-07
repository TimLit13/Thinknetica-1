# Заполнить хеш гласными буквами, где значением будет являтся 
# порядковый номер буквы в алфавите (a - 1).

hash = Hash.new

('a'..'z').to_a.each_with_index do |letter, index|
  if "aeiouy".include?(letter.to_s)
    hash[letter] = index + 1
  end
end

# puts hash
