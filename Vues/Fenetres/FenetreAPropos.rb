#
#Definition de la fenêtre "à propos de".

require "gtk2"
require "glib2"
include Gtk

class FenetreÀPropos

	def initialize
		
		apropos = [
			"\nLuc FONTAINE(Chef de Projet)", 
			"Choukri SOULEYMAN-IMAN(Documentaliste)",
			"Mohammed Amine HAJIR(Developpeur)",
			"Youssef LAMNIY(Developpeur)",
			"Wajdi GUEDOUAR(Developpeur)",
			"Yann GUENVER(Developpeur)",
			"Yannick ESSIA(Developpeur)",			
		]
		
		about = AboutDialog.new
		about.set_program_name "ProjetPicross"
		about.set_version "1"
		about.set_authors(apropos)
		about.set_copyright "(c) Groupe C"
		about.run
		about.destroy

	end

end
