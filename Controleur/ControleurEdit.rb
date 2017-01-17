# encoding: utf-8

##
# Version 0.1



load "./Modele/Jeu.rb"
load "./Vues/VueEdit.rb"
#load "BaseDonnee.rb"

require_relative '../Modele/Jeu'
require_relative '../Modele/BaseDonnee'


require_relative 'Controleur'
require_relative 'ControleurSauvegarde'
class ControleurEdit < Controleur

	# Constructeur
	def ControleurEdit.creer(unJeu,unJoueur,uneGrille,unTab,mode)
		new(unJeu,unJoueur,uneGrille,unTab,mode)
	end

	def initialize(unJeu,unJoueur,uneGrille,unTab,mode)

		super(unJeu,unJoueur)

		@vue = VueEdit.creer(uneGrille)


		@vue.table.each{|uneCase|
			if (uneCase.class==CaseVue) then
				# Si une case est cliquée
				uneCase.signal_connect("button_press_event") {|laCase, event|

					# On relache le clique
					Gdk::Display.default.pointer_ungrab(Gdk::Event::CURRENT_TIME)

					# Si clique gauche
					if (event.button == 1) then
						if @vue.grille.revel then
							@vue.grille.revelerXY(laCase.x,laCase.y)
							@vue.actualiserCase(laCase.x,laCase.y)
						else
							@vue.grille.modifierXY(laCase.x,laCase.y)
							@vue.actualiserCase(laCase.x,laCase.y)
						end
					elsif (event.button == 3) then
						@vue.grille.modifierXYDroit(laCase.x,laCase.y)
						@vue.actualiserCase(laCase.x,laCase.y)
					end

					#puts uneGrille

				}

				#Lors du passage de la souris on vérifie qu'on a pas un bouton de la souris appuyé
				uneCase.signal_connect("enter-notify-event"){|laCase, event|
					if event.state == Gdk::Window::BUTTON1_MASK
						@vue.grille.modifierXY(laCase.x,laCase.y)
						@vue.actualiserCase(laCase.x,laCase.y)
					elsif event.state == Gdk::Window::BUTTON3_MASK
						@vue.grille.modifierXYDroit(laCase.x,laCase.y)
						@vue.actualiserCase(laCase.x,laCase.y)
					end
				}
			end

		}

		@vue.window.signal_connect('delete_event'){
			changerControleur(ControleurMenu.creer(@jeu,@joueur))
			#changerControleur(ControleurSauvegarde.creer(@jeu,@joueur))
		}

		@vue.boutonAnnuler.signal_connect("clicked"){ changerControleur(ControleurEditeur.creer(@jeu,@joueur)) }

		@vue.textNom.signal_connect("insert_text") {
			@vue.boutonSauvegarder.sensitive = @vue.textNom.text.empty? ? false : true
		}

		#Quand on appuie sur btnSauvegarder, on crée la matrice de jeu
		@vue.boutonSauvegarder.signal_connect("clicked"){

			#Test pour une largeur de 5
			@jeu.bd.save_grillePersonnalisee(@joueur, @vue.grille.matrice, @vue.grille.largeur, @vue.textNom.text)
			confirmerEnregistrement(@vue.textNom.text)
			changerControleur(ControleurMenu.creer(@jeu,@joueur))

		}

	end



	# Confirme à l'utilisateur que la sauvegarde à été effectuée
	def confirmerEnregistrement(nom_sauvegarde)
		dialog = MessageDialog.new(
			nil,
			Dialog::DESTROY_WITH_PARENT | Dialog::MODAL,
			MessageDialog::INFO,
			MessageDialog::BUTTONS_CLOSE,
			"Grille \n\""+nom_sauvegarde+"\"\nenregistrée !"
		)

		dialog.run
		dialog.destroy
	end
end
