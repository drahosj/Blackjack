#! /usr/bin/env ruby

require './ui.rb'
require 'yaml'

mode = :load
size = 4

ARGV.each do |arg|
  if arg.upcase == "NEW"
    mode = :new
  elsif arg.upcase ==  "LOAD"
    mode = :load
  elsif arg.to_i != 0
    size = arg.to_i
  end
end

p mode
p size
game = nil

if mode == :load
  if File.exists? "state.sav"
    File.open "state.sav" do |file|
      game = YAML.load(file)
      game.spawn_ui
    end
  else
    game = Game.new(size)
  end
else mode == :new
  game = Game.new(size)
end

File.open("state.sav", "w") do |file|
  YAML.dump(game, file)
end
