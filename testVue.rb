load "Grille.rb"
load "Vues/VueJeu.rb"

class VerifVue
	def testerVue
		
		uneGrille=Grille.creer(10)
		puts uneGrille.dimension
		
		puts uneGrille.pileCoup.taille
		
		unevue = VueJeu.creer(uneGrille)
		Gtk.main
		
	end
end

essaie=VerifVue.new
essaie.testerVue
