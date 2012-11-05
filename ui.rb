require 'gtk2'
require './classes.rb'

class Game
  def initialize(size=4)
    @hand = Array.new
    @hide_card = true
    @dealer_hand = Array.new
    @shoe = Shoe.new(size)
    @shoe.shuffle

    @dealer_hand.push(@shoe.draw_card)
    @dealer_hand.push(@shoe.draw_card)

    @hand.push(@shoe.draw_card)
    @hand.push(@shoe.draw_card)

    spawn_ui
  end
  def refresh_dealer_hand_frame
    @dealer_hand_labels.each do |label|
      label.destroy
    end

    @dealer_hand_labels = Array.new
    
    i = 0
    @dealer_hand.each do |card|
      if (i == 0) and @hide_card
        @dealer_hand_labels.push(Gtk::Label.new("?????????"))
      else
        @dealer_hand_labels.push(Gtk::Label.new(card.to_s, true))
      end
      i += 1
    end

    @dealer_hand_labels.each do |label|
      @dealer_hand_box.pack_start(label, false, false, 2)
    end
    
    @button_draw.label = ("_draw [#{@shoe.get_cards_left.to_s}]")
    @dealer_hand_box.show_all
  end

  def refresh_hand_frame
    @hand_labels.each do |label|
      label.destroy
    end

    @hand_labels = Array.new
    
    @hand.each do |card|
      @hand_labels.push(Gtk::Label.new(card.to_s, true))
    end

    @hand_labels.each do |label|
      @hand_box.pack_start(label, false, false, 2)
    end

    @button_draw.label = ("_Draw [#{@shoe.get_cards_left.to_s}]")
    @hand_box.show_all
  end
  def spawn_ui
    @hand_labels = Array.new
    @dealer_hand_labels = Array.new

    @button_draw = Gtk::Button.new("_draw [#{@shoe.get_cards_left.to_s}]")
    @button_draw.signal_connect("clicked") do
      @hand.push(@shoe.draw_card)
      refresh_hand_frame
    end

    @button_new_hand = Gtk::Button.new("_New Hand")
    @button_new_hand.signal_connect("clicked") do
      @hand = Array.new
      @dealer_hand = Array.new
      @dealer_hand.push(@shoe.draw_card)
      @dealer_hand.push(@shoe.draw_card)
      @hide_card = true
      @hand.push(@shoe.draw_card)
      @hand.push(@shoe.draw_card)
      refresh_dealer_hand_frame
      refresh_hand_frame
    end

    @button_new_shoe = Gtk::Button.new("_Shuffle Deck")
    @button_new_shoe.signal_connect("clicked") do
      @shoe = Shoe.new(4)
      @hand = Array.new
      @dealer_hand = Array.new
      @dealer_hand.push(@shoe.draw_card)
      @dealer_hand.push(@shoe.draw_card)
      @hide_card = true
      @hand.push(@shoe.draw_card)
      @hand.push(@shoe.draw_card)
      refresh_hand_frame
      refresh_dealer_hand_frame
    end

    @dealer_button_draw = Gtk::Button.new("Dea_ler Draw")
    @dealer_button_draw.signal_connect("clicked") do
      unless @hide_card
        @dealer_hand.push(@shoe.draw_card)
      else 
        @hide_card = false
      end
      refresh_dealer_hand_frame
    end

    @window = Gtk::Window.new
    @window.signal_connect("delete_event") { false }
    @window.signal_connect("destroy") { Gtk.main_quit }
    
    @button_box = Gtk::VBox.new(false, 0)
    @button_box.pack_start(@button_draw, false, false, 10)
    @button_box.pack_start(@button_new_hand, false, false, 10)
    @button_box.pack_start(@button_new_shoe, false, false, 15)

    @dealer_button_box = Gtk::VBox.new(false, 0)
    @dealer_button_box.pack_start(@dealer_button_draw, false, false, 10)

    @hand_frame = Gtk::Frame.new("Hand")
    @dealer_hand_frame = Gtk::Frame.new("Dealer")
    
    @h_box = Gtk::HBox.new(false, 0)
    @h_box.pack_start(@button_box, false, false, 5)
    @h_box.pack_start(@hand_frame, true, true, 5)
    @h_box.pack_start(@dealer_hand_frame, true, true, 5)
    @h_box.pack_start(@dealer_button_box, false, false, 5)

    @window.border_width = 10
    @window.set_default_size(700, 170)
    @window.add(@h_box)

    @hand_box = Gtk::VBox.new(false, 0)
    @hand_frame.add(@hand_box)

    @dealer_hand_box = Gtk::VBox.new(false, 0)
    @dealer_hand_frame.add(@dealer_hand_box)
    
    refresh_dealer_hand_frame
    refresh_hand_frame

    @window.show_all

    Gtk.main
  end
end
