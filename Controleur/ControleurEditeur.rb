# encoding: utf-8

##
# Version 0.1


#########   CONTROLEUREDITEUR.RB   ########

require_relative '../Vues/VueEditeur'
require_relative '../Modele/Jeu'
require_relative '../Modele/BaseDonnee'
require_relative '../Modele/picture'


require_relative 'Controleur'
require_relative 'ControleurJeu'
require_relative 'ControleurEdit'
require_relative 'ControleurSauvegarde'
require_relative 'ControleurNomGrille'



class ControleurEditeur < Controleur

    def ControleurEditeur.creer(unJeu,unJoueur)
  		new(unJeu,unJoueur)
    end

    def initialize(unJeu,unJoueur)

  		super(unJeu, unJoueur)
  		@vue = VueEditeur.creer()

  		@vue.rbVierge.signal_connect("clicked") {
  			@vue.boutonChargerImage.set_sensitive(false)
  			@vue.entryPath.set_visible(false)
  			@chemin = "vierge"
  		}

  		@vue.rbPleine.signal_connect("clicked") {
  			@vue.boutonChargerImage.set_sensitive(false)
  			@chemin = "pleine"
  			@vue.entryPath.set_visible(false)
  		}

  		@vue.rbCharger.signal_connect("clicked"){
  			@vue.boutonChargerImage.set_sensitive(true)
  			@vue.entryPath.set_visible(true)
  			@chemin = "image?"
  		}


  		#Ecouteur boutton charger Image
  		@vue.boutonChargerImage.signal_connect("clicked"){
  			dialog = FileChooserDialog.new("Charger Image", nil, FileChooser::ACTION_OPEN, nil,
  				[Stock::CANCEL, Dialog::RESPONSE_CANCEL],
  				[Stock::OPEN, Dialog::RESPONSE_ACCEPT]
  			)

  			if dialog.run == Dialog::RESPONSE_ACCEPT
  				puts "filename = #{dialog.filename}"
  			end


  			@vue.entryPath.set_text(@chemin = dialog.filename.to_s)


  			dialog.destroy
  		}


  		@vue.boutonValider.signal_connect("clicked"){

  			if (@vue.rb5.active?) then @tailleGrille = 5
  			elsif (@vue.rb10.active?)then @tailleGrille = 10
  			elsif (@vue.rb15.active?) then @tailleGrille = 15
  			elsif (@vue.rb20.active?) then @tailleGrille = 20
  			end

  			#quitterJeu


  			@grilleDetat

  			if @chemin == "vierge"

  				grilleDetat = Jeu.getInstance.grilleEditer(@tailleGrille, 1)
  				changerControleur(ControleurEdit.creer(@jeu,@joueur,grilleDetat,nil,2))

  				#changerControleur(ControleurJeu.creer(@jeu,@joueur,grilleDetat,nil, 3))


  			elsif @chemin == "pleine"
  			  	grilleDetat = Jeu.getInstance.grilleEditer(@tailleGrille, 0)
  			  	changerControleur(ControleurEdit.creer(@jeu,@joueur,grilleDetat,nil,2))
       	else

       	 	imageCreation= PicrossImage.lire(@chemin)
  				matrice=imageCreation.toPicross(@tailleGrille)
  				grilleDetat = GrilleImage.creer(@tailleGrille,matrice)
       	 	changerControleur(ControleurNomGrille.creer(@jeu, @joueur, grilleDetat.matrice, grilleDetat.largeur))

			  end

  				# nota : c'est possible que l'image soit toute blanche
  				# même si l'image d'origine n'est pas un carré blanc
  				# c'est juste qu'avec la compression, ça tranforme en tout en blanc
  				# pour vérifier que ça marche bien, tester sur une 25x25
  				#puts @chemin.split("/")[-1]
  		#	  grilleDetat = Jeu.getInstance.grilleImage(@tailleGrille,@chemin)
  				#imageCreation= PicrossImage.lire(@chemin)
  				#matrice=imageCreation.toPicross(@tailleGrille)
  				#grilleDetat = GrilleImage.creer(@tailleGrille,matrice)
          #print "imagePicross:#{image.afficherMatrice}\n"

        #  p grilleDetat
       #   @jeu.bd.save_grillePersonnalisee(@joueur, grilleDetat.matrice, grilleDetat.largeur, "nom_matrice")
       #   changerControleur(ControleurMenu.creer(@jeu,@joueur))
  		#	end


  			#grilleEditable = GrilleEditable.new(picross, grilleDetat)

  		}#fin de clic du boutonOK


  		@vue.btretour.signal_connect('clicked') {
  			changerControleur(ControleurMenu.creer(@jeu,@joueur))
  		}

  		#btretour.signal_connect("clicked"){ destroy }


  		@vue.window.signal_connect('delete_event') {
  			quitterJeu

  		}
	end




end
