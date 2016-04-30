##
# Auteur YOUSSEF LAMNIY
# Version 0.1
#

######## 	VUEEDITEUR.RB 	########

######## 	IMPORTS 	########



require "gtk2"
require "glib2"
include Gtk

	# * *Description*:
	# 
 	# VueEditeur qui a pour tâche de présenter une interface de choix de grilles à éditer,
 	# 	Elle permet d'afficher les options d'édition que 
	#	l'utilisateur pourra paramétrer pour pouvoir travailler sur une grille en mode Edition.
 	#
 	## * *Exemple ici*:
	#	
	#	@window.add(editionTaille)
	#		
	# * *Retourne*:
	#
	# renvoie la fenêtre dans laquelle est attaché la méthode editionTaille contenant la fenetre
	# permettant l'affichage du menu editeur dans lequel nous pouvons editer les grilles à la taille souhaitée
	#
class VueEditeur < Vue

    @tailleGrille
	@chemin	#Texte qui est toit "vide" soit l'image soit plein(en cours).
 	@btretour

 	@rbVierge
 	@rbPleine

	@rb5
	@rb10
	@rb15
	@rb20

	@entryPath

	@boutonChargerImage

	@rbCharger

	@boutonValider

    attr_reader :btretour, :rbVierge, :rbPleine, :rb5, :rb10, :rb15, :entryPath, :boutonChargerImage, :rbCharger, :boutonValider, :rb20


    def VueEditeur.creer()
		new()
	end


	# Vue chargée de présenter une interface de choix de grille
	def initialize()

		@chemin = "vierge"

		super("Editer")

		@window.add(editionTaille)
		    
		@window.show_all



	end

	# * *Description*:
	# 
 	# 	Methode qui a pour tâche de présenter une interface de choix de grilles à éditer,
 	# 	Elle permet le paramétrage d'une grille pour que l'utilisateur ait le choix dans son édition.
 	#
	#		
	# * *Retourne*:
	#
	# renvoie la verticale box principale dans laquelle sont placés tous les éléments qui permettent l'edition d'une grille
	#
	 def editionTaille()
        vBoxPrincipal = Gtk::VBox.new(false,3)
		vBoxPrincipal.pack_start(hBoxHaut 	= HBox.new(false, 25))
		vBoxPrincipal.pack_start(hBoxMilieu	= HBox.new(false, 20))
		vBoxPrincipal.pack_start(hBoxBas 	= HBox.new(false, 25))


		hBoxHaut.pack_start(Frame.new("Taille").add(vBoxTaille = VBox.new(false, 25)))

		vBoxTaille.pack_start(@rb5 	= RadioButton.new("5 x 5"))
		vBoxTaille.pack_start(@rb10 	= RadioButton.new(rb5, "10 x 10"))
		vBoxTaille.pack_start(@rb15	= RadioButton.new(rb10, "15 x 15"))
		vBoxTaille.pack_start(@rb20 	= RadioButton.new(rb15, "20 x 20"))

		hBoxHaut.pack_start(Frame.new("Type").add(vBoxType = VBox.new(false, 25)))

		vBoxType.pack_start(@rbVierge = RadioButton.new("Vierge"))
		vBoxType.pack_start(@rbPleine = RadioButton.new(rbVierge, "Pleine"))

		#rbVierge = RadioButton.new("Vierge")

		vBoxType.pack_start(hBoxChargerImage = HBox.new(false, 25))
		hBoxChargerImage.pack_start(@rbCharger = RadioButton.new(rbPleine, " "))
		hBoxChargerImage.pack_start(@boutonChargerImage = Button.new("Charger Image"))
    @boutonChargerImage.set_image(Gtk::Image.new(File.expand_path("./Icons/load.png", File.dirname(__FILE__))))
		boutonChargerImage.set_sensitive(false)

		hBoxMilieu.pack_start(@entryPath = Entry.new)



		#Ajout de la 2eme horizontal box contenant les boutons
		hBoxBas.pack_start(@boutonValider = Button.new("Valider"))
    @boutonValider.set_image(Gtk::Image.new(File.expand_path("./Icons/ok.png", File.dirname(__FILE__))))

		#hBoxBas.pack_start(btretour = Button.new(Stock::CLOSE), true, true)
		hBoxBas.pack_start(@btretour = Gtk::Button.new("Retour"))
    @btretour.set_image(Gtk::Image.new(File.expand_path("./Icons/return.png", File.dirname(__FILE__))))



		#set_modal(true)



        return vBoxPrincipal
    end



end
