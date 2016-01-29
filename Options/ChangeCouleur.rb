#!/usr/bin/env ruby

require 'gtk2'

def area_event(area, e)
      if Gdk::EventButton === e
             colorsel_d = Gtk::ColorSelectionDialog.new("Choisir une couleur de fond pour votre PiCross")
             color = area.modifier_style.bg(Gtk::STATE_NORMAL)
             colorsel = colorsel_d.colorsel
             colorsel.previous_color = color
             colorsel.current_color = color

             colorsel.has_palette = true
             colorsel.has_opacity_control = true
             colorsel.signal_connect("color_changed") do |w|
                     ncolor = w.current_color
                     area.modify_bg(Gtk::STATE_NORMAL, ncolor)
             end
             unless colorsel_d.run == Gtk::ColorSelectionDialog::RESPONSE_OK
                     area.modify_bg(Gtk::STATE_NORMAL, color)
             end
             colorsel_d.destroy
             true
     else
             false
     end
end

window = Gtk::Window.new
window.title = "Double cliquez sur la fenêtre pour changer la couleur du Picross"
window.resizable = true

window.signal_connect("delete_event") do
     Gtk.main_quit
     true
end

box = Gtk::DrawingArea.new
box.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.new(0, 0, 65535))

window.set_size_request(700, 500)
box.set_events(Gdk::Event::BUTTON_PRESS_MASK)
box.signal_connect("event") {|w, e| area_event(w, e)}

window.add(box)
window.show_all

Gtk.main
