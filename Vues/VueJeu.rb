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
	
	# tableau de la matrice à afficher
	@table
	# grille de picross à résoudre
	@grille
	
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
	
	#Crée le menu en haut de la fenêtre de jeu
	def creerMenu
	
		mb = Gtk::MenuBar.new
		
		#Niveau 1
		fichier = Gtk::MenuItem.new("Fichier")
		@miRageQuit = Gtk::MenuItem.new("Quitter")
		
		#Niveau 2 (Fichier)
		menuFichier = Gtk::Menu.new
		@miQuitter = Gtk::MenuItem.new("Quitter")
		
		menuFichier.append(@miQuitter)
		
		fichier.set_submenu(menuFichier)
		
		mb.append(fichier)
		mb.append(@miRageQuit)
		
		return mb
	end
	
	#Crée la tête de la fenêtre (Timer - VBoxAide)
	def creerEntete
	
		hbox = Gtk::HBox.new(false, 50)
		
		@lbTimer = Gtk::Label.new
		vboxAide = creerVBoxAide
		
		hbox.pack_start(@lbTimer)
		hbox.pack_start(vboxAide)
		
	end
	
	#Crée une VBox contenant les boutons Joker et Indice
	def creerVBoxAide
	
		vbox = Gtk::VBox.new(false, 3)
		
		@btAide = Gtk::Button.new
		@nbAide = 3
		
		vbox.pack_start(@btAide)
		vbox.pack_start(Gtk::Label.new("Nombre d'aides restantes: "+@nbAide.to_s))
		
		return vbox
	end
	
	#Crée le plateau de jeu à partir de la grille
	def creerPlateau
	
		tailleGrille = @grille.largeur
		espacementCases = 2
		
		@table = Gtk::Table.new(tailleGrille+1, tailleGrille+1, false)#On rajoute 1 pour insérer les infos des colonnes
		
		#Infos des colonnes
		0.upto(tailleGrille-1){|x|
		
			#@table.attach(@grille.horizontal[x], x+1, x+2, 0, 1)
		}
		
		#Infos des lignes
		0.upto(tailleGrille-1){|y|
		
			#@table.attach(@grille.verticale[y], 0, 1, y+1, y+2)
		}
		
		#Création de la grille
		0.upto(tailleGrille-1){|x|
		
			0.upto(tailleGrille-1){|y|
			
				caseTemp = CaseVue.new("blanc", tailleGrille, x, y)
				@table.attach(caseTemp, x+1, x+2, y+1, y+2)
			}
		}
		
		#Définition de l'espacement des cases toutes les 5 cases
		5.step(tailleGrille, 5){|i|
		
			@table.set_row_spacing(i, espacementCases)
			@table.set_column_spacing(i, espacementCases)
		}
		
		return @table
	end
	
	# Retourne un temps sous le format chronomètre à partir d'un entier
	def genererTemps(unNombre)
	
		return unNombre.to_s
	end
	
	# Met à jour la vue
	def miseAJour
		
		tailleGrille = @grille.largeur
		
		# Mise à jour de toutes les cases du plateau à partir du modèle
		0.upto(tailleGrille-1){|x|
			0.upto(tailleGrille-1){|y|
				
			}
		}
		
		# Désactivation du bouton d'aide si plus disponible
		if @nbAide ==0 then
		
			@btAide.sensitive = false 
			@btAide.label = "Aide"
			
		else
		
			@btAide.sensitive = true
			@btAide.label = "Aide"
		end
		
		@window.show_all

	end
	
	#Actualise la case située aux coordonnées (x,y)
	def actualiserCase(x,y)
		
		#Doit devenir....
		if @grille.matrice[x][y].etatCourant == 0 and not getCaseVue(x,y).etat.eql?("blanc")
		
			getCaseVue(x,y).changerEtat("blanc")
			
		elsif @grille.matrice[x][y].etatCourant == 1 and not getCaseVue(x,y).etat.eql?("noir")
		
			getCaseVue(x,y).changerEtat("noir")
		
		end
	end
	
	def getCaseVue(unX, unY)
	
		return @table[unX+1][unY+1]
	end
	
end
