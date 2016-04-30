#!/usr/bin/env ruby
# encoding=utf-8

# Auteur YANN GUENVER
# Version 0.1
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant la classe ControleurJeu du jeu du Picross


load "./Modele/Jeu.rb"
load "./Vues/VueJeu.rb"
#load "BaseDonnee.rb"

require_relative 'Controleur'
require_relative 'ControleurSauvegarde'

# Classe ControleurJeu
# * *Variables*	:
#
# * *Heritage*	: Controleur
#
class ControleurJeu < Controleur

    # Méthode de création d'un ControleurJeu
	#
	# * *Paramètres*:
	# - +unJeu+ -> Le jeu du Picross
	# - +unJoueur+ -> Le pseudonyme du joueur
	# - +uneGrille+ -> La grille de jeu
	# - +unTab+ -> Le tableau contenant les informations d'une grille si elle est chargée
	# - +mode+ -> Le mode de jeu
	# * *Exemple* :
	#
    def ControleurJeu.creer(unJeu,unJoueur,uneGrille,unTab,mode,extra)
		new(unJeu,unJoueur,uneGrille,unTab,mode,extra)
    end

	def initialize(unJeu,unJoueur,uneGrille,unTab,mode,extra)

		super(unJeu,unJoueur)

		@vue = VueJeu.creer(uneGrille)
		if unTab != nil then
			@vue.nbSolution = unTab[3]+1
			@vue.miseAJourNbSolution
			@vue.timer.start(unTab[2])
		end
		if mode==1 then rang = extra[1] end

		@vue.miseAJourTimer
		@vue.miseAJourAide

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
					# Sinon si clique droit
					elsif (event.button == 3) then
						@vue.grille.modifierXYDroit(laCase.x,laCase.y)
						@vue.actualiserCase(laCase.x,laCase.y)
					end

					@vue.hideFleche

					if uneGrille.estTerminerMultiSoluce? and mode != 0 then
						case mode
						when 1 then
							tab = Array.new(4)
							tab[2] = @vue.timer.elapsed
							tab[3] = 3

							matriceScenario = @jeu.bd.charger_picrossAventure(extra[0],extra[1])
							msg = Gtk::MessageDialog.new(@vue.window, Gtk::Dialog::DESTROY_WITH_PARENT,
										Gtk::MessageDialog::INFO,
										Gtk::MessageDialog::BUTTONS_CLOSE,
										matriceScenario[1])
							msg.run
							msg.destroy

							if (@jeu.bd.get_nombrePicross(extra[0]))[0] > extra[1] then
								extra[1] += 1
								matriceScenario = @jeu.bd.charger_picrossAventure(extra[0],extra[1])
								changerControleur(ControleurJeu.creer(@jeu,@joueur,Jeu.getInstance.chargerGrille(matriceScenario[0],matriceScenario[0][0].length),tab,1,extra))
							else
								changerControleur(ControleurMenu.creer(@jeu,@joueur))
								@jeu.bd.save_score(@vue.timer.elapsed,@joueur,0,1, uneGrille.largeur, extra[0])
							end
						when 2 then
							@jeu.bd.save_score(@vue.timer.elapsed,@joueur,0,2, uneGrille.largeur, "nomAventureGrille")
							changerControleur(ControleurMenu.creer(@jeu,@joueur))
						when 3 then
							@jeu.bd.save_score(@vue.timer.elapsed,@joueur,0,3, uneGrille.largeur, extra)
							changerControleur(ControleurMenu.creer(@jeu,@joueur))

						end
					end
				}

				#Lors du passage de la souris on vérifie qu'on a pas un bouton de la souris appuyé
				uneCase.signal_connect("enter-notify-event"){|laCase, event|
					if event.state == Gdk::Window::BUTTON1_MASK
					@vue.grille.modifierXY(laCase.x,laCase.y)
					@vue.actualiserCase(laCase.x,laCase.y)
					puts uneGrille.estTerminerMultiSoluce?
					elsif event.state == Gdk::Window::BUTTON3_MASK
					@vue.grille.modifierXYDroit(laCase.x,laCase.y)
					@vue.actualiserCase(laCase.x,laCase.y)
					puts uneGrille.estTerminerMultiSoluce?
					end
				}
			end
		}

		# Si on clique sur le bouton Retour, on dépile le dernier coup
		@vue.btRetour.signal_connect('clicked'){
			@vue.grille.pile.depiler
			@vue.miseAJour
		}

		# Si on clique sur le bouton hypothèse, on active/désactive le mode hypothèse
		@vue.btHypothese.signal_connect('clicked'){
			if @vue.grille.pile.flag then
				@vue.grille.pile.validerHypothese
				@vue.miseAJour
			else
				@vue.grille.pile.activerHypothese
			end
			@vue.miseAJourHyp
		}

		# Si on clique sur le bouton annuler hypothèse, on dépile tout les coups joués en mode hypothèse
		@vue.btRetourHypothese.signal_connect('clicked'){
			@vue.grille.pile.annulerHyp
			@vue.miseAJour
			@vue.miseAJourHyp
		}

		# Si on détruit la fenêtre, on retourne au menu principal
		@vue.window.signal_connect('delete_event'){
			changerControleur(ControleurMenu.creer(@jeu,@joueur))
			#changerControleur(ControleurSauvegarde.creer(@jeu,@joueur))
		}

		# Si on clique sur le bouton solution, on active le mode solution
		@vue.btSolution.signal_connect('clicked') {
			if !@vue.grille.revel && @vue.nbSolution > 0 then
				@vue.grille.activerRevelation
				@vue.miseAJourNbSolution
			end
		}

		# Si on clique sur le bouton aide, on affiche l'aide disponible
		@vue.btAide.signal_connect('clicked') {
			tab = @vue.grille.suggestion
			@vue.showFleche(tab[0],tab[1],tab[2])
		}

		# Si on clique sur le bouton sauvegarder, on sauvegarde la partie
		@vue.btSauvegarde.signal_connect('clicked') {
			case mode
			when 1 then changerControleur(ControleurSauvegarde.creer(@jeu, @joueur, @vue.timer.elapsed , @vue.grille.pile , @vue.grille, @vue.nbSolution, "ma_grille", 1, rang, extra[0])) #Si c'est une Aventure
			when 2 then changerControleur(ControleurSauvegarde.creer(@jeu, @joueur, @vue.timer.elapsed , @vue.grille.pile , @vue.grille, @vue.nbSolution, "ma_grille", 2, nil, nil)) #Si c'est une partie détente
			when 3 then	changerControleur(ControleurSauvegarde.creer(@jeu, @joueur, @vue.timer.elapsed , @vue.grille.pile , @vue.grille, @vue.nbSolution, "ma_grille", 3, nil, nil)) #Si c'est une grille éditée
			end
		}

		#@vue.btRetro.signal_connect('clicked'){
		#	@vue.grille.retrospective
		#	@vue.miseAJour
		#	tout les coups sont joués à nouveau
		#	@vue.grille.retro.each{ |coup|
		#		coup.case.etatCourant=coup.newEtat
		#		sleep(1)
		#		@vue.miseAJour
		#	}
		#}
    end
end
