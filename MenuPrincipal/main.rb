#!/usr/bin/env ruby


###
# Auteur Youssef LAMNIY
# Date : Lundi 25 Janvier 2016
# Description : Main.
###

begin
  require 'rubygems'
 rescue LoadError
end

require 'gtk2'

load 'MenuPrincipal.rb'
load 'Jeu.rb'
load 'Highscore.rb'
load 'Reglages.rb'
load 'CommentJouer.rb'


Gtk.init

def onDestroy
	puts "Fin de l'application"
	Gtk.main_quit
end

def report_press(w); puts "Lauching (button) w=#{w}"; end

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



# Création du Layout

maBox=Gtk::VBox.new()


MenuPrincipal.add(maBox)



#maBox1.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.new(0, 0, 65535))


#maBox1.set_events(Gdk::Event::BUTTON_PRESS_MASK)
#maBox1.signal_connect("event") {|w, e| area_event(w, e)}


# Création du Label
texte = "<span font_desc=\"Times New Roman italic 35\" foreground=\"#000000\">Menu Principal</span>\n"


monLabel=Gtk::Label.new()
monLabel.set_markup(texte)
monLabel.set_justify(Gtk::JUSTIFY_CENTER)

#
#
maBox.add(monLabel)



# Création des Boutons
monBout1=Gtk::Button.new("Jouer")
monBout2=Gtk::Button.new("Highscore")
monBout3=Gtk::Button.new("Comment jouer?")
monBout5=Gtk::Button.new("Reglages")
monBout6=Gtk::Button.new("Quitter")


maBox.add(monBout1)
maBox.add(monBout2)
maBox.add(monBout3)
maBox.add(monBout5)
maBox.add(monBout6)


monBout1.signal_connect( "clicked" ) {
			MenuPrincipal.hide_all
			Jeu.show_all
		 }
		 
monBout2.signal_connect( "clicked" ) {
			MenuPrincipal.hide_all
			Highscore.show_all
		 }
		 
monBout3.signal_connect( "clicked" ) {
			MenuPrincipal.hide_all
			Jouer.show_all
		 }


monBout5.signal_connect( "clicked" ) do 
	    MenuPrincipal.hide_all
		Reglages.show_all

end

monBout6.signal_connect( "clicked" ) do 
	Gtk.main_quit
    
end



#Preparation en cas de changement de couleur
MenuPrincipal.signal_connect("event") {|w, e| area_event(w, e)}


#Affichage de la fenêtre
MenuPrincipal.show_all


Gtk.main
