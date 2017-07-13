require 'erb'

kids_data      = File.read('data/kids-data.txt')
invoice        = File.read('templates/invoice_sample_letter.txt.erb')
EXPENSIVE_TOY  = 1000
CHEAP_TOY      = 100
FREE_TOY       = 0
HST            = 0.13

kids_data.each_line do |kid|

  kid_data_array = kid.split

  name          = kid_data_array[0].capitalize
  behavior      = kid_data_array[2]
  toys          = kid_data_array[3..8]
  street_number = kid_data_array[9]
  street_name   = kid_data_array[10]
  street_suffix = kid_data_array[11]
  postal_code   = kid_data_array[12]
  house_value   = kid_data_array[13].to_i



#  makes an array of hashes for each kid
  list_of_toys = [] # use list of toys in the letter erb file
  if behavior == "nice"
    toys.each do |toy|
      toy_hash = {}
      toy_hash[:name] = toy
      if toy == "Kaleidoscope"
        toy_price = FREE_TOY
      elsif house_value > 1000000
          toy_price = EXPENSIVE_TOY
      elsif house_value >= 200000
          toy_price = CHEAP_TOY
      elsif house_value < 200000
        toy_price = FREE_TOY
      end
      toy_hash[:price] = toy_price
      list_of_toys << toy_hash
    end
  else
    toy_hash = {}
    toy_hash[:name] = "Defective Toy"
      if house_value > 1000000
          toy_price = EXPENSIVE_TOY
      elsif house_value >= 200000
          toy_price = CHEAP_TOY
      elsif house_value < 200000
        toy_price = FREE_TOY
      end
      toy_hash[:price] = toy_price
      list_of_toys << toy_hash
  end

  subtotal = 0
  list_of_toys.each do |toy_hash|
    toy_price = toy_hash[:price]
    subtotal += toy_price
  end

  tax = 0
  list_of_toys.each do |toy_hash|
    tax = toy_hash[:price] * HST
  end

  total = 0
  list_of_toys.each do |toy_hash|
    toy_price = toy_hash[:price]
    total = (toy_price * HST) + toy_price
  end

# subtotal toy prices

# calculate tax

# total toy prices with tax

  next unless house_value > 0

  p house_value
  p list_of_toys

  filename    = 'letters/invoices/' + name + '.txt'
  letter_text = ERB.new(invoice, nil, '-').result(binding)

  puts "Writing #{filename}."
  File.write(filename, letter_text)

end

puts 'Done!'
