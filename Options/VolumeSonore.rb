#!/usr/bin/env ruby
 
require 'gtk2'
Gtk.init
 
#ascenseur qui permet d'ajuster le volume
scale_vol=Gtk::VScale.new(0,100,1)
scale_vol.value=75
scale_vol.show
#fenêtre pop-up
wvol=Gtk::Window.new(Gtk::Window::POPUP)
wvol.set_default_size(40,200)
wvol.add(scale_vol)
 
#Bouton "volume" qui contrôle l'apparition de 
bvol=Gtk::Button.new
bvol.label='Volume'
 
box=Gtk::VBox.new(true)
box.pack_start(bvol)
box.pack_start(Gtk::Label.new('Fenêtre principale'))
window=Gtk::Window.new
window.signal_connect("destroy"){Gtk.main_quit}
window.add(box)
window.show_all
 
 
bvol.signal_connect('clicked'){
#Déplacer et afficher la fenêtre popup
	position=window.position+window.pointer
	wvol.move(position[0]+position[2]-20,position[1]+position[3])#postion de la fenêtre principale + position du bouton volume
	wvol.show
#Cacher la fenêtre popup lors d'un clic dans la fenêtre principal
	mask=window.events#sauvegarde du masque événements de la fenêtre principale
	window.add_events(Gdk::Event::BUTTON_PRESS_MASK)#Surveiller les clics dans la fenêtre principale
	window.signal_connect("button_press_event"){
		wvol.hide
		window.events=mask#Restaurer le masque par défaut
	}
}
 
Gtk.main