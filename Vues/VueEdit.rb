##
# Auteur Youssef LAMNIY
# Version 0.1

###### VUEEDIT.RB #######

###### IMPORTS ########

require_relative 'Vue'
require_relative 'CaseVue'
require 'gtk2'
load "./Modele/Timer.rb"

	# * *Description*:
	# 
 	# Classe VueEdit qui a pour tâche de présenter une interface contenant la grille editée avec le champ de nom de sauvegarde
	#		
	# * *Retourne*:
	#
	# Renvoie la grille editable
	#	
class VueEdit < Vue

	# label de la vue
	@timer

	@boutonAnnuler
	@boutonSauvegarder

	@textNom

	@table # tableau d'affichage de la grille
	@tableM # tableau d'affichage des boutons
	@mat # matrice à afficher
	@grille # grille de picross à résoudre
	@matFleche # matrice de fleche


	attr_reader :table, :btRetour, :boutonSauvegarder, :boutonAnnuler, :textNom, :grille
	attr_accessor :timer
	private_class_method :new

	def VueEdit.creer(uneGrille)
		new(uneGrille)
	end


	def initialize(uneGrille)

		super("Jeu")
		@grille = uneGrille


		
		# HBox principale
		hbox = Gtk::HBox.new(false, 10)

		@window.add(hbox)

		hbox.pack_start(creerPlateau)
		hbox.pack_start(creerTableAide)
		hbox.set_border_width(5)

		miseAJour

		@window.show_all
		
	end


	# * *Description*:
	# 
	# Methode retournant une verticale box qui contient le champ de saisie du nom de la grille et les boutons sauvegarder et annuler	
	#		
	# * *Retourne*:
	#
	# Renvoie la vBox avec le champ du nom de la grille et les boutons sauvegarder et annuler
	#	
		def creerTableAide
		

		vbox = VBox.new(false, 3)
		
		#Grille
		vbox.pack_start(hBoxMilieu = HBox.new(false, 2))
		hBoxMilieu.add(vBoxBas = HBox.new(false))
		vBoxBas.add(table = Table.new(4,4))
		
		vbox.add(@textNom = Entry.new)
		textNom.set_text("nom de la grille")
		textNom.set_width_chars(15)
		textNom.set_max_length(25)
		
		vbox.add(hBoxBas = HBox.new(false, 2))
		hBoxBas.pack_start(@boutonSauvegarder = Button.new(Stock::OK))
		hBoxBas.pack_start(@boutonAnnuler = Button.new(Stock::CANCEL))
	

		#table.attach(table, 1, 2, 1, 2)


		return vbox
	end




	# * *Description*:
	# 
	# Methode retournant le plateau de la grille editable
	#		
	# * *Retourne*:
	#
	# Renvoie la table contenant le plateau
	#
		def creerPlateau

		tailleGrille = @grille.largeur
		espacementCases = 2

		@table = Gtk::Table.new(tailleGrille+2, tailleGrille+2, false) # On rajoute 2 pour insérer les infos et les fleches
		@mat = Array.new(tailleGrille) {Array.new(tailleGrille)}
		@matFleche = Array.new(2) {Array.new(tailleGrille)}

		
		# Création de la grille
		0.upto(tailleGrille-1){|x|
			0.upto(tailleGrille-1){|y|
				caseTemp = CaseVue.new("blanc", tailleGrille, @grille, x, y)
				@table.attach(caseTemp, y+2, y+3, x+2, x+3)
				@mat[x][y] = caseTemp
			}
		}
		# Définition de l'espacement des cases toutes les 5 cases
		6.step(tailleGrille, 5){|i|
			@table.set_row_spacing(i, espacementCases)
			@table.set_column_spacing(i, espacementCases)
		}

		return @table
	end


	# * *Description*:
	# 
	# Methode mettant à jour la grille
	#		
	# * *Retourne*:
	#
	# Renvoie la mise à jour
	#
	def miseAJour

		tailleGrille = @grille.largeur

		# Mise à jour de toutes les cases du plateau
		0.upto(tailleGrille-1){|x|
			0.upto(tailleGrille-1){|y|
				actualiserCase(x,y)
			}
		}

		@window.show_all
		
	end

	# * *Description*:
	# 
	# Methode qui actualise la case située aux coordonnées (x,y)
	#
	# * *Exemple *: 
	#
	#  actualiserCase(x,y)
	#		
	# * *Retourne*:
	#
	# Renvoie l'actualisation
	#
		def actualiserCase(x,y)

		# Doit devenir....

		if @grille.matrice[x][y].etatCourant == 0 and not getCaseVue(x,y).etat.eql?("noir")

			getCaseVue(x,y).changerEtat("noir")

		elsif @grille.matrice[x][y].etatCourant == 1 and not getCaseVue(x,y).etat.eql?("blanc")

			getCaseVue(x,y).changerEtat("blanc")

		elsif @grille.matrice[x][y].etatCourant == 2 and not getCaseVue(x,y).etat.eql?("croix")

			getCaseVue(x,y).changerEtat("croix")

		end
	end

		# * *Description*:
	# 
	# Methode qui renvoi une case à des coordonnées passés en paramètres
	#		
	# * *Retourne*:
	#
	# Renvoie la case concernée
	#
	def getCaseVue(unX, unY)

		return @mat[unX][unY]
	end
end
