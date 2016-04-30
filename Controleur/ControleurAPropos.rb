#!/usr/bin/env ruby
# encoding=utf-8 

# Auteur HAJIR Mohammed Amine
# Description : fichier contenant la classe ControleurAPropos du Picross

######   CONTROLEURAPROPOS.RB   ######

require 'gtk2'

load "./Vues/VueAPropos.rb"

require_relative 'Controleur'
require_relative 'ControleurJeu'

=begin
class ControleurAPropos < Controleur


def initialize(unJeu,unJoueur)

super(unJeu,unJoueur)

@vue = VueAPropos.creer()


#@vue.btretour.signal_connect('clicked') {
#	changerControleur(ControleurMenu.creer(@jeu,@joueur))
#}

#@vue.window.signal_connect('delete_event') {
#	quitterJeu
#}

end

end
=end

class ControleurAPropos < Controleur

      public_class_method :new

      def initialize(jeu, joueur)

            @vue = VueAPropos.new()    
            #@vue = VueAPropos.creer()
            super(jeu, joueur)
            @vue.afficher()

            @vue.btretour.signal_connect('clicked') {
				@vue.fermerFenetre
            }

            #@window.boutonPrecedent.signal_connect('clicked'){
	  #mouvement(EventsAccueil.new(@jeu, position()))
            #}

      end
end
