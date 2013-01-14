require "set"
require "andreymarkov/markov_table"

describe MarkovTable do
  it "only builds possible sentences" do
    m = MarkovTable.new(should_load = false)
    m.update("hi", "bot")
    m.update("bot", :end)

    s = Set.new
    100.times do
      s.add m.make_sentence
    end

    s.to_a.sort.should == ["hi bot", "bot"].sort
  end

  it "dumps correctly" do
    m = MarkovTable.new(should_load = false)
    m.update("hi", "bot")
    m.update("bot", :end)

    m.save_dump

    m = MarkovTable.new(should_load = true)
    s = Set.new
    100.times do
      s.add m.make_sentence
    end

    s.to_a.sort.should == ["hi bot", "bot"].sort
  end
end
