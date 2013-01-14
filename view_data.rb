require "pp"

hash = Marshal.load(File.binread(".andrey"))
outer_count = hash.keys.count
inner_count = 0
hash.each do |key,value|
  value.each do |key2, value2|
    inner_count += value2
  end
end

puts outer_count
puts inner_count
