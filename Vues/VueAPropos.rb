#!/usr/bin/env ruby
# encoding=utf-8 

# Auteur YOUSSEF LAMNIY / HAJIR Mohammed Amine
# Version 0.1
# Description : fichier contenant la classe VueAPropos Picross

#####   VUEAPROPOS.RB   ######


#####   IMPORTS   ######
require_relative 'Vue'

require 'gtk2'
require "glib2"
include Gtk

=begin
class VueAPropos < Vue


    @btretour

    attr_reader :btretour


    def VueAPropos.creer()
		new()
	end

	def initialize()

		super("A Propos")

        	apropos = [
        	"\nYannick ESSIA\n",
			"Luc FONTAINE\n",
			"Wajdi GUEDOUAR\n",
			"Yann GUENVER\n",
			"Mohammed Amine HAJIR\n",
			"Youssef LAMNIY\n",
			"Choukri SOULEYMAN-IMAN\n",
		]

		about = AboutDialog.new
		about.set_program_name "Projet Picross"
		about.set_version "V.1"
		about.set_authors(apropos)
		about.set_copyright " Groupe C - L3SPI 2015"
		about.run
		about.destroy

		#vBox.pack_start(@btretour = Gtk::Button.new("Retour"))


	end
end
=end

	# * *Description*:
	# 
	# Classe VueAPropos qui permet de renvoyer la fenêtre contenant les membres du groupe
	#		
	# * *Retourne*:
	#
	# Renvoie une fenêtre contenant les informations concernant le groupe ayant realisé ce projet
	#

class VueAPropos < Vue

      @btretour
      @texteCredits
      attr_reader :btretour, :texteCredits

      public_class_method :new


      def VueAPropos.creer()
            new()
      end


      def initialize()
            super("A Propos")
            @window.set_title("Credits")
			@window.set_modal(true)
            @btretour = Gtk::Button.new('Précedent')
            @btretour.set_size_request(6, 30)
            @texteCredits = Gtk::Label.new(" PROJET LICENCE 3 SPI  -  JEU PICROSS  -  PROMO 2015/2016\n 
	 Remerciements:\n

	        Chef de projet - Luc FONTAINE

	        Documentaliste - Souleyman Imane CHOUKRI 

	        Developpeur - Mohammed Amine HAJIR

	        Developpeur - Yann GUENVER

	        Developpeur - Youssef LAMNIY

	        Developpeur - Wajdi GUEDWAR

	        Developpeur - Yannick ESSIA")

            vBox = Gtk::VBox.new(false, 0)
            vBox.set_border_width(25)
            vBox.pack_start(@texteCredits, true, true, 30)
            vBox.pack_start(@btretour, false, true, 0)
            @window.add(vBox)
      end

end
