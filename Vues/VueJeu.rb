##
# Auteur YANN GUENVER
# Version 0.1
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant la classe VueJeu du jeu du Picross
#encoding: UTF-8

require_relative 'Vue'
require_relative 'CaseVue'

require 'gtk2'

# Vue chargée de présenter une interface de jeu
class VueJeu < Vue

	@miQuitter
	@miRageQuit

	@lbTimer
	
	@btAide
	
	# tableau d'affichage
	@table
	# tableau de la matrice à afficher
	@mat
	# grille de picross à résoudre
	@grille
	
	
	attr_reader :table
	private_class_method :new
	
	def VueJeu.creer(uneGrille)
		new(uneGrille)
	end
	
	def initialize(uneGrille)
	
		super("Jeu")
		@grille = uneGrille
		
		# HBox principale
		hbox = Gtk::HBox.new(false, 10)
		@window.add(hbox)

		hbox.pack_start(creerPlateau)
		hbox.pack_start(creerVBoxAide)
		hbox.set_border_width(5)

		miseAJour
		
		@window.show_all
	end
	
	
	# Crée une VBox contenant les boutons Joker et Indice
	def creerVBoxAide
	
		vbox = Gtk::VBox.new(true, 5)
		
		@btAide = Gtk::Button.new("Aide")
		@btIndice = Gtk::Button.new("Indice")
		
		vbox.(@btAide)
		vbox.(@btIndice)
		
		return vbox
	end
	
	# Crée le plateau de jeu à partir de la grille
	def creerPlateau
	
		tailleGrille = @grille.largeur
		espacementCases = 2
		
		@table = Gtk::Table.new(tailleGrille+3, tailleGrille+3, false) # On rajoute 1 pour insérer les infos des colonnes
		@mat = Array.new(tailleGrille) {Array.new(tailleGrille)}
		
		# Infos des colonnes
		0.upto(tailleGrille-1){|x|
		
			#@table.attach(@grille.horizontal[x], x+1, x+2, 0, 1)
			@table.attach(infoHorizontal(@grille.horizontal[x]), x+2, x+3, 1, 2)
		}
		
		# Infos des lignes
		0.upto(tailleGrille-1){|y|
		
			#@table.attach(@grille.verticale[y], 0, 1, y+1, y+2)
			@table.attach(infoVertical(@grille.vertical[y]), 1, 2, y+2, y+3)
		}
		
		#Création de la grille
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
	
	def infoHorizontal(ind)
		
		vBoxTemp = Gtk::VBox.new()
		unless ind.empty?
			ind.each{|elem|
				labelTemp = Gtk::Label.new()
				labelTemp.set_markup(elem.to_s)
				vBoxTemp.add(labelTemp)
			}
		end
		
		return vBoxTemp
	end
	
	def infoVertical(ind)
		
		hBoxTemp = Gtk::HBox.new()
		unless ind.empty?
			ind.each{|elem|
				labelTemp = Gtk::Label.new()
				labelTemp.set_markup(elem.to_s+" ")
				hBoxTemp.add(labelTemp)
			}
		end
		
		return hBoxTemp
	end
	
	# Retourne un temps sous le format chronomètre à partir d'un entier
	def genererTemps(unNombre)
	
		return unNombre.to_s
	end
	
	# Met à jour la vue
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
	
	# Actualise la case située aux coordonnées (x,y)
	def actualiserCase(x,y)
		
		# Doit devenir....
		if @grille.matrice[x][y].etatCourant == 0 and not getCaseVue(x,y).etat.eql?("blanc")
		
			getCaseVue(x,y).changerEtat("blanc")
		
		elsif @grille.matrice[x][y].etatCourant == 1 and not getCaseVue(x,y).etat.eql?("noir")
		
			getCaseVue(x,y).changerEtat("noir")
		
		end
	end
	
	def getCaseVue(unX, unY)
	
		return @mat[unX][unY]
	end
end
