##
# Auteur YANN GUENVER
# Version 0.1
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant le test de la classe Vue

load "Grille.rb"
load "Vues/VueJeu.rb"

class VerifVue
	def testerVue
		
		uneGrille=Grille.creer(10)
		
		Gtk.init
		
		uneVue = VueJeu.creer(uneGrille)
		
		uneVue.window.signal_connect('destroy') {Gtk.main_quit}
		Gtk.main
		
	end
end

essaie=VerifVue.new
essaie.testerVue
