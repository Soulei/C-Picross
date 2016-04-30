#!/usr/bin/env ruby
# encoding=utf-8

# Auteur YANN GUENVER
# Version 0.1
# Date : Mardi 26 Janvier 2016
# Description : fichier contenant la classe ControleurJouer du jeu du Picross


require_relative '../Vues/VueJouer'
require_relative '../Modele/Jeu'
require_relative '../Modele/BaseDonnee'

require_relative 'Controleur'
require_relative 'ControleurJeu'

# Classe Controleur
# * *Variables*	:
#
# * *Heritage*	: Controleur
#
class ControleurJouer < Controleur

	# Méthode de création d'un ControleurJouer
	#
	# * *Paramètres*:
	# - +unJeu+ -> Le jeu du Picross
	# - +unJoueur+ -> Le pseudonyme du joueur
	# * *Exemple* :
	#
    def ControleurJouer.creer(unJeu,unJoueur)
	new(unJeu,unJoueur)
    end

    def initialize(unJeu,unJoueur)

		super(unJeu,unJoueur)
		@vue = VueJouer.creer()

		#Si il existe des partie sauvegardée, on les affiche
		if @jeu.bd.nomsParties_Sauvegarde(@joueur) != nil then
			@jeu.bd.nomsParties_Sauvegarde(@joueur).each { |s|
				case s[1]
				when 1 then @vue.comboChargerA.append_text(s[0])
				when 2 then @vue.comboChargerD.append_text(s[0])
				when 3 then @vue.comboChargerE.append_text(s[0])
				end
			}
		end
		#Si il existe des Aventures, on les affiche
		if @jeu.bd.nomsAventures() != nil then
			@jeu.bd.nomsAventures().each { |s|
				@vue.comboAventure.append_text(s)
			}
			@vue.comboAventure.active = 0
			@vue.flagAventure = true
		end
		#Si il existe des grilles éditées, on les affiche
		if @jeu.bd.nomsGrilleEdit(@joueur) != nil then
			@jeu.bd.nomsGrilleEdit(@joueur).each { |s|
				@vue.comboEdit.append_text(s)
			}
			@vue.comboEdit.active = 0
			@vue.flagEdit = true
		end

		@vue.MiseAJourMode

		#Si on clique sur le bouton Creer, on créé une partie en fonction des informations sélectionnées
		@vue.btCreer.signal_connect('clicked') {
			case @vue.comboMode.active
			when 0 then #Si c'est une Aventure
				nomAventure = @vue.comboAventure.active_text

				matriceScenario = @jeu.bd.charger_picrossAventure(nomAventure,1)
				matrice = matriceScenario[0]
				taille =  matrice[0].length

				extra = [nomAventure,1]
				changerControleur(ControleurJeu.creer(@jeu,@joueur,Jeu.getInstance.chargerGrille(matrice,taille),nil,1,extra))
			when 1 then #Si c'est une partie détente
				case @vue.comboGrille.active
				when 0 then changerControleur(ControleurJeu.creer(@jeu,@joueur,Jeu.getInstance.grille5x5,nil,2,nil))
				when 1 then changerControleur(ControleurJeu.creer(@jeu,@joueur,Jeu.getInstance.grille10x10,nil,2,nil))
				when 2 then changerControleur(ControleurJeu.creer(@jeu,@joueur,Jeu.getInstance.grille15x15,nil,2,nil))
				when 3 then changerControleur(ControleurJeu.creer(@jeu,@joueur,Jeu.getInstance.grille20x20,nil,2,nil))
				end
			when 2 then #Si c'est une grille éditée
				nomEdit = @vue.comboEdit.active_text

				matrice = @jeu.bd.charge_grillePersonnalisee(nomEdit)
				taille =  matrice[0].length
				grille = Jeu.getInstance.chargerGrille(matrice,taille)
				changerControleur(ControleurJeu.creer(@jeu,@joueur,grille,nil,3,nomEdit))
			end
		}

		#Si on clique sur le bouton Charger, on charge une partie en fonction du nom sélectionné
		@vue.btCharger.signal_connect('clicked') {
			case @vue.comboMode.active
				when 0 then pCharger = @jeu.bd.charger_partie(@joueur,@vue.comboChargerA.active_text) #Si c'est une Aventure
				when 1 then pCharger = @jeu.bd.charger_partie(@joueur,@vue.comboChargerD.active_text) #Si c'est une partie détente
				when 2 then pCharger = @jeu.bd.charger_partie(@joueur,@vue.comboChargerE.active_text) #Si c'est une grille éditée
			end

			case pCharger[5]
			when 1 then #Si c'est une Aventure
				extra = [pCharger[6],pCharger[5]]
				changerControleur(ControleurJeu.creer(@jeu,@joueur,Jeu.getInstance.chargerCharger(pCharger),pCharger,1,extra))
			when 2 then #Si c'est une partie détente
				changerControleur(ControleurJeu.creer(@jeu,@joueur,Jeu.getInstance.chargerCharger(pCharger),pCharger,2,nil))
			when 3 then #Si c'est une grille éditée
        extra = pCharger[6]
				changerControleur(ControleurJeu.creer(@jeu,@joueur,Jeu.getInstance.chargerCharger(pCharger),pCharger,3,extra))
			end
		}

		#Si on clique sur le bouton Retour, on retourne sur le menu principal
		@vue.btRetour.signal_connect('clicked') {
			changerControleur(ControleurMenu.creer(@jeu,@joueur))
		}

		# Si on détruit la fenêtre, on retourne au menu principal
		@vue.window.signal_connect('delete_event') {
			changerControleur(ControleurMenu.creer(@jeu,@joueur))
		}
    end
end
