require 'gtk2'
require './classes.rb'

class Game
    def initialize
        @hand = Array.new
        @shoe = Shoe.new(4)
        @shoe.shuffle

        spawnUI
    end
    def refreshHandFrame
        @handLabels.each do |label|
            label.destroy
        end

        @handLabels = Array.new
        
        @hand.each do |card|
            @handLabels.push(Gtk::Label.new(card.to_s, true))
        end

        @handLabels.each do |label|
            @handBox.pack_start(label, false, false, 2)
        end
        @handBox.show_all
    end
    def spawnUI
        @handLabels = Array.new

        @buttonDraw = Gtk::Button.new("_Draw")
        @buttonDraw.signal_connect("clicked") {
            @hand.push(@shoe.draw_card)
            refreshHandFrame
        }

        @buttonNewHand = Gtk::Button.new("_New Hand")
        @buttonNewHand.signal_connect("clicked") {
            @hand = Array.new
            refreshHandFrame
        }
        @window = Gtk::Window.new
        @window.signal_connect("delete_event") { false }
        @window.signal_connect("destroy") { Gtk.main_quit }
        
        @buttonBox = Gtk::VBox.new(false, 0)
        @buttonBox.pack_start(@buttonDraw, false, false, 10)
        @buttonBox.pack_start(@buttonNewHand, false, false, 10)

        @handFrame = Gtk::Frame.new("Hand")
        
        @hBox = Gtk::HBox.new(false, 0)
        @hBox.pack_start(@buttonBox, false, false, 5)
        @hBox.pack_start(@handFrame, true, true, 5)

        @window.border_width = 10
        @window.set_default_size(400, 170)
        @window.add(@hBox)

        @handBox = Gtk::VBox.new(false, 0)
        @handFrame.add(@handBox)

        @window.show_all

        Gtk.main
    end
end
