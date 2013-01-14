require "pp"

PP.pp(Marshal.load(File.binread(".andrey")))
