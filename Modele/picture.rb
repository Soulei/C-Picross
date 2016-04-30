###########################################################################
# -*- encoding: utf-8 -*-
# PICTURE.RB
# créer des grilles à partir d'images
# HAJIR MOHAMMED AMINE 
###########################################################################

# gem rmagick nécessaire aux traitements d'images en Ruby
# il permet d'utiliser les fonctionnalités du logiciel imageMagick et de manipuler des images de façon automatisée
require "rmagick"

# appel du module Magick
include Magick

#Les états d'une case de la matrice sont définis dans ce fichier
require_relative 'outils'


#################################
# PicrossImage
#################################
# Classe qui tranforme une image en picross (en matrice noir/blanc).
# La fonction principale est toPicross qui fait tout le travail --> d'une image elle renvoi une matrice
# A utiliser plutot pour générer des images de taille 15*15 ou plus car en dessou le résultat n'est pas très correct.
#
# Procédure de l'algorithme :
# 	1° Monochromiser l'image
#	2° Reduire l'image à 5*5 ou 10*10 ...
# 	3° Remonochromiser l'image
#
# * *Variable*	:
#    - +image+   -> l'image sur laquelle on fait des traitements
#    - +matrice+ -> la matrice contenant soit un Etat blanc, soit un Etat noir générée à partir de l'image
#	    c'est cette matrice qu'on va remplire et qui sera le resultat final suite aux traitements effectués sur l'image
#	    elle n'est initialisée qu'à l'appel de la méthode imageToPicross
# * *Heritage*	: Aucun lien
#
class PicrossImage

      # Variables
      @image
      @matrice

      # Génération des accesseurs en lecture
      attr_reader :image
      attr_reader :matrice

      # méthode de CLASSE qui lit un fichier image à partir duquel elle crée une instance d'imagePicross
      #
      # * *Paramètres* :
      #   - +picFile+ -> nom du fichier image qu'on souhaite convertir en matrice
      #
      # * *Retourne* :
      #
      # * *Raises* : aucune exception
      #
      # * *Exemple* :
      #
      def PicrossImage.lire(picFile)
            new(picFile)
      end

      # méthode permettant de créer un objet image à partir du nom du fichier image passé en paramètre
      #
      # * *Paramètres* :
      #   - +picFile+ -> nom du fichier image qu'on souhaite convertir en matrice
      #
      # * *Retourne* :
      #
      # * *Raises* : aucune exception
      #
      # * *Exemple* :
      #
      def initialize(picFile)
      @image = Magick::ImageList.new(picFile)
      end

      # méthode qui transforme une image en gamme de gris (photo noir et blanc classique)
      #
      # * *Paramètres* :
      #
      # * *Retourne* : une image en gamme de gris
      #
      # * *Raises* : aucune exception
      def greyScale!
            return @image = @image.quantize(256, Magick::GRAYColorspace)
      end

      # pour verifier si une image est en gamme de gris
      #
      # * *Paramètres* :
      #
      # * *Retourne* :true or false
      #
      # * *Raises* : aucune exception
      def greyScale?
            return @image.grey?
      end

      # transforme une image en pixels qui sont soit noir soit blanc
      #
      # * *Paramètres* :
      #
      # * *Retourne* : une image en pixels noir et blanc
      #
      # * *Raises* : aucune exception
      def monochrome!
            return @image = @image.quantize(2, Magick::GRAYColorspace)
      end

      # pour enregistrer une image dans un fichier dont le nom est passé en paramètre
      #
      # * *Paramètres* :
      #   - +nameFile+ -> nom du nouveau fichier image
      #
      # * *Retourne* :
      #
      # * *Raises* : aucune exception
      def enregistrer(nameFile)
            @image.write(nameFile)
      end

      # pour l'affichage une image
      def afficher
            @image.display
      end

      # pixelise l'image (méthode destructive)
      #
      # * *Paramètres* :
      #   - +taille+ -> nombre de pixels souhaité
      #
      # * *Retourne* :
      #
      # * *Raises* : aucune exception
      #
      # * *Exemple* : si taille = 5 on aura une image 5*5
      #
      def pixeliser!(taille)
            return @image.resize_to_fit!(taille)
      end

      # Contraste l'image. Plus n est grand, plus le contraste est fort.
      #
      # * *Paramètres* :
      #   - +n+ -> niveau du contraste
      #
      # * *Retourne* :
      #
      # * *Raises* : aucune exception
      #
      # * *Exemple* :  n à 50 donne un assez fort contraste.
      #
      def contraster!(n)
            n.times{
	  @image = @image.contrast(true)
            }
      end

      # Convertit l'image noir et blanc en matrice noir et blanc (on prendra comme composante le rouge)
      # le blanc dans l'image correspond à 1
      # le noir dans l'image correspond à 0
      #
      # * *Paramètres* :
      #   - +taille+ -> taille souhaitée pour la matrice
      #
      # * *Retourne* : la matrice de 0 et de 1 correspondant à l'image
      #
      # * *Raises* : aucune exception
      #
      def imageToPicross(taille)
            @matrice = Array.new(taille) { Array.new(taille) }

	  0.upto(taille - 1){ |y|
	        0.upto(taille - 1){ |x|
	              @matrice[x][y] = (@image.pixel_color(x,y).red == 0 ? Etat.Noir: Etat.Blanc)
	        }
	              }
            return matrice
      end

      #
      # tranforme l'image en picross dont la taille est passée en argument
      # algorithme : monochrome, pixeliser, monochrome :
      # cet algo donne de plutôt bons résultats
      # si on ne monochrome pas avant et après le résultat est bien moins bon
      #
      # * *Paramètres* :
      #   - +taille+ -> taille souhaitée pour la matrice
      #
      # * *Retourne* : la matrice du picross (valeurs sont soit Etat.Blanc soit Etat.Noir)
      #
      # * *Raises* : aucune exception
      #
      def toPicross(taille)
            # pour le picross il faut une rotation
            # @image.rotate!(90)
            self.monochrome!
            self.pixeliser!(taille)
            self.monochrome!

            return @matrice = self.imageToPicross(taille)
      end

      # affiche la matrice
      #
      # * *Paramètres* :
      #
      # * *Retourne* : la matrice du picross sous format texte
      #
      # * *Raises* : aucune exception
      #
      def afficherMatrice
            texte = ""
            0.upto(@matrice.size-1){ |y|
	  0.upto(@matrice.size-1){ |x|
	        texte += @matrice[x][y].to_s
	  }
            texte += "\n"
            }
            return texte
      end


end #fin de classe

# Test

#image = PicrossImage.lire("superman.jpg")

#pour afficher le picross résolu
#taille = 20
#image.toPicross(taille)
#image.enregistrer("picrossSuperman.jpeg")

#output = File.new("superman.txt", "w")
#output.write(image.afficherMatrice)
