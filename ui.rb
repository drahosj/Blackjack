require 'gtk2'
require './classes.rb'

class Game
    def initialize
        @hand = Array.new
        @hideCard = true
        @dealerHand = Array.new
        @shoe = Shoe.new(4)
        @shoe.shuffle

        @dealerHand.push(@shoe.draw_card)
        @dealerHand.push(@shoe.draw_card)

        spawnUI
    end
    def refreshDealerHandFrame
        @dealerHandLabels.each do |label|
            label.destroy
        end

        @dealerHandLabels = Array.new
        
        i = 0
        @dealerHand.each do |card|
            if (i == 0) and @hideCard
                @dealerHandLabels.push(Gtk::Label.new("?????????"))
            else
                @dealerHandLabels.push(Gtk::Label.new(card.to_s, true))
            end
            i += 1
        end

        @dealerHandLabels.each do |label|
            @dealerHandBox.pack_start(label, false, false, 2)
        end
        
        @buttonDraw.label = ("_Draw [#{@shoe.getCardsLeft.to_s}]")
        @dealerHandBox.show_all
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

        @buttonDraw.label = ("_Draw [#{@shoe.getCardsLeft.to_s}]")
        @handBox.show_all
    end
    def spawnUI
        @handLabels = Array.new
        @dealerHandLabels = Array.new

        @buttonDraw = Gtk::Button.new("_Draw [#{@shoe.getCardsLeft.to_s}]")
        @buttonDraw.signal_connect("clicked") do
            @hand.push(@shoe.draw_card)
            refreshHandFrame
        end

        @buttonNewHand = Gtk::Button.new("_New Hand")
        @buttonNewHand.signal_connect("clicked") do
            @hand = Array.new
            @dealerHand = Array.new
            @dealerHand.push(@shoe.draw_card)
            @dealerHand.push(@shoe.draw_card)
            @hideCard = true
            refreshDealerHandFrame
            refreshHandFrame
        end

        @buttonNewShoe = Gtk::Button.new("_Shuffle Deck")
        @buttonNewShoe.signal_connect("clicked") do
            @shoe = Shoe.new(4)
            @hand = Array.new
            @dealerHand = Array.new
            @dealerHand.push(@shoe.draw_card)
            @dealerHand.push(@shoe.draw_card)
            @hideCard = true
            refreshHandFrame
            refreshDealerHandFrame
        end

        @dealerButtonDraw = Gtk::Button.new("Dea_ler Draw")
        @dealerButtonDraw.signal_connect("clicked") do
            unless @hideCard
                @dealerHand.push(@shoe.draw_card)
            else 
                @hideCard = false
            end
            refreshDealerHandFrame
        end

        @window = Gtk::Window.new
        @window.signal_connect("delete_event") { false }
        @window.signal_connect("destroy") { Gtk.main_quit }
        
        @buttonBox = Gtk::VBox.new(false, 0)
        @buttonBox.pack_start(@buttonDraw, false, false, 10)
        @buttonBox.pack_start(@buttonNewHand, false, false, 10)
        @buttonBox.pack_start(@buttonNewShoe, false, false, 15)

        @dealerButtonBox = Gtk::VBox.new(false, 0)
        @dealerButtonBox.pack_start(@dealerButtonDraw, false, false, 10)

        @handFrame = Gtk::Frame.new("Hand")
        @dealerHandFrame = Gtk::Frame.new("Dealer")
        
        @hBox = Gtk::HBox.new(false, 0)
        @hBox.pack_start(@buttonBox, false, false, 5)
        @hBox.pack_start(@handFrame, true, true, 5)
        @hBox.pack_start(@dealerHandFrame, true, true, 5)
        @hBox.pack_start(@dealerButtonBox, false, false, 5)

        @window.border_width = 10
        @window.set_default_size(700, 170)
        @window.add(@hBox)

        @handBox = Gtk::VBox.new(false, 0)
        @handFrame.add(@handBox)

        @dealerHandBox = Gtk::VBox.new(false, 0)
        @dealerHandFrame.add(@dealerHandBox)
        
        refreshDealerHandFrame
        refreshHandFrame

        @window.show_all

        Gtk.main
    end
end
