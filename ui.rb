require 'gtk2'
require './classes.rb'

class Game
    def initialize
        @hand = Array.new
        @shoe = Shoe.new(4)
        @shoe.shuffle

        spawnUI
    end
    def spawnUI
        @buttonDraw = Gtk::Button.new("Draw")
        @buttonDraw.signal_connect("clicked") {
            @hand.push(@shoe.draw_card)
        }
        @buttonShowHand = Gtk::Button.new("Show Hand")
        @buttonShowHand.signal_connect("clicked") {
            @hand.each do |card|
                puts(card.to_s)
            end
        }
        @buttonNewHand = Gtk::Button.new("New Hand")
        @buttonNewHand.signal_connect("clicked") {
            @hand = Array.new
        }
        @window = Gtk::Window.new
        @window.signal_connect("delete_event") { false }
        @window.signal_connect("destroy") { Gtk.main_quit }
        
        @box = Gtk::VBox.new(false, 0)
        @box.pack_start(@buttonDraw, false, false, 10)
        @box.pack_start(@buttonShowHand, false, false, 10)
        @box.pack_start(@buttonNewHand, false, false, 30)

        @window.border_width = 10
        @window.add(@box)

        @window.show_all

        Gtk.main
    end
end
