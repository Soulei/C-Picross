##
# Auteur YANN GUENVER
# Version 0.1
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant le test de la classe Vue

load "Controleur/ControleurNouveauJeu.rb"

class VerifVue
	def testerVue
		
		ControleurNouveauJeu.creer
		
	end
end

essaie=VerifVue.new
essaie.testerVue
