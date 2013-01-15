require "pp"

hash = Marshal.load(File.binread(".andrey"))
outer_count = hash.keys.count
inner_count = 0
hash.each do |key,value|
  value.each do |key2, value2|
    inner_count += value2
  end
end

puts "words in lexicon #{outer_count}"
puts "total transitions #{inner_count}"

require "andreymarkov/markov_table"

x = MarkovTable.new


l = []

100.times do
  l << x.make_sentence.length
end

puts "average sentence length #{l.inject(:+) / 100.0}"

lexicon_density = hash.map {|key,internal| internal.keys.count * 1.0 / hash.keys.count}.inject(:+) / hash.keys.count
puts "lexicon density #{lexicon_density}"
