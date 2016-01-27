
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
		    
		    #Lors du passage de la souris on vérifie qu'on a pas un bouton de la souris appuyé
		    i.signal_connect("enter-notify-event"){|laCase, event|
			if event.state == Gdk::Window::BUTTON1_MASK
			    @vue.grille.modifierXY(laCase.x,laCase.y)
			    @vue.grille.estTerminer?
			    @vue.actualiserCase(laCase.x,laCase.y)
			    #@modele.getCase(laCase.x, laCase.y).clicGauche
			    #@modele.ajouterClic
			    #lancerVerification
			    #@vue.actualiserCase(laCase.x, laCase.y)
			#elsif event.state == Gdk::Window::BUTTON3_MASK
			    #@modele.getCase(laCase.x, laCase.y).clicDroit
			    #@modele.ajouterClic
			    #lancerVerification
			    #@vue.actualiserCase(laCase.x, laCase.y)
			end
		    }
		}
		
		@vue.btRetour.signal_connect('clicked'){
		    @vue.grille.pileCoup.depiler
		    @vue.miseAJour
		}
		
	end
end

