load "Grille.rb"
load "Vues/VueJeu.rb"

class VerifVue
	def testerVue
		
		uneGrille=Grille.creer(10)
		puts uneGrille.dimension
		
		puts uneGrille.pileCoup.taille
		
		uneVue = VueJeu.creer(uneGrille)
		
		uneVue.signal_connect('destroy') {Gtk.main_quit}
		Gtk.main
		
	end
end

essaie=VerifVue.new
essaie.testerVue
