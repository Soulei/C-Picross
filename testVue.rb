##
# Auteur YANN GUENVER
# Version 0.1
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant le test de la classe Vue

load "Jeu.rb"
load "Vues/VueJeu.rb"

class VerifVue
	def testerVue
		unJeu=Jeu.new
		uneGrille=unJeu.grille5x5
		puts uneGrille
		
		Gtk.init
		
		uneVue = VueJeu.creer(uneGrille)
		
		
		uneVue.table.each{|i|
			
			if (i.class==CaseVue) then
			
				
				i.signal_connect("button_press_event") {
					
					Gdk::Display.default.pointer_ungrab(Gdk::Event::CURRENT_TIME)
					
					i.grille.modifierXY(i.x,i.y)
					uneVue.miseAJour()
					if uneGrille.estTerminer? then
						Gtk.main_quit
					end
					puts uneGrille
					puts uneGrille.estTerminer? 
				}
			end
		}
		
		
		uneVue.window.signal_connect('destroy') {Gtk.main_quit}
		Gtk.main
		
	end
end

essaie=VerifVue.new
essaie.testerVue
