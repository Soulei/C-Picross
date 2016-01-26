
load "Grille.rb"
load "Vues/VueJeu.rb"

class ControleurJeu < Controleur

	def ControleurJeu.creer(uneGrille)
		new(uneGrille)
	end

	def initialize(uneGrille)
	
		
		
		@vue = VueJeu.creer(uneGrille)
		@vue.table.each{|i|
		
		if (i.class==CaseVue) then
			i.signal_connect("button_press_event") {
			
			Gdk::Display.default.pointer_ungrab(Gdk::Event::CURRENT_TIME)
			
			i.grille.modifierXY(i.x,i.y)
			@vue.miseAJour()
			
			if uneGrille.estTerminer? then
				Gtk.main_quit
			end
			
			puts uneGrille
			puts uneGrille.estTerminer?
			
			}
		end
		}
		
	end
end

