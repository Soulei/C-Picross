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
	@nbAide
	
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
		
		# VBox principale
		vbox = Gtk::VBox.new(false, 5)
		@window.add(vbox)

		vbox.pack_start(creerMenu)
		vbox.pack_start(creerEntete)
		vbox.pack_start(creerPlateau)
		
		vbox.set_border_width(5)

		arial18 = Pango::FontDescription.new('Arial 20')
		@lbTimer.modify_font(arial18)

		miseAJour
		
		@window.show_all
	end
	
	# Crée le menu en haut de la fenêtre de jeu
	def creerMenu
	
		mb = Gtk::MenuBar.new
		
		# Niveau 1
		fichier = Gtk::MenuItem.new("Fichier")
		@miRageQuit = Gtk::MenuItem.new("Quitter")
		
		# Niveau 2 (Fichier)
		menuFichier = Gtk::Menu.new
		@miQuitter = Gtk::MenuItem.new("Quitter")
		
		menuFichier.append(@miQuitter)
		
		fichier.set_submenu(menuFichier)
		
		mb.append(fichier)
		mb.append(@miRageQuit)
		
		return mb
	end
	
	# Crée la tête de la fenêtre (Timer - VBoxAide)
	def creerEntete
	
		hbox = Gtk::HBox.new(false, 50)
		
		@lbTimer = Gtk::Label.new
		vboxAide = creerVBoxAide
		
		hbox.pack_start(@lbTimer)
		hbox.pack_start(vboxAide)
		
	end
	
	# Crée une VBox contenant les boutons Joker et Indice
	def creerVBoxAide
	
		vbox = Gtk::VBox.new(false, 3)
		
		@btAide = Gtk::Button.new
		@nbAide = 3
		
		vbox.pack_start(@btAide)
		vbox.pack_start(Gtk::Label.new("Nombre d'aides restantes: "+@nbAide.to_s))
		
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
				labelTemp.set_markup(elem.to_s)
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
