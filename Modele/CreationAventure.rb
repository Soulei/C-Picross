##
# Auteur SOULEIMAN IMAN Choukri & ESSIA Yannick
# Version 0.1
# Date : Lundi 11 Janvier 2016
# Description : fichier contenant la classe BaseDonnee du jeu du Picross

load "./Modele/picture.rb"
load "./Modele/outils.rb"
load "./Modele/BaseDonnee.rb"

#Classe permettant de creer une aventure
# * *Paramètres* : nom de l'aventure, dossier contenant les images de l'aventure, fichier contenant le scénario
# * *Variables*	:
#    - +PREMIER_SCORE+ -> Constante permettant d'indiquer le type de score
#    - +SECOND_SCORE+ ->Constante permettant d'indiquer le type de score
# * *Heritage*	: Aucun lien
#
class CreationAventure
  @dossierImage
  @fileScenario
  @nomAventure
  @bd
  def initialize
    if(ARGV.size == 3)
      @bd = BaseDonnee.new

      @nomAventure = ARGV[0]
      @dossierImage = ARGV[1]
      @fileScenario = ARGV[2]
      #Nombre de picross dans l'aventure
      numPicross = Dir.entries(@dossierImage).count{ |x|
        x != '.' and x != '..' and File.extname(x) != ".txt"
      }
      #Creer l'aventure
      @bd.ajout_aventure(@nomAventure, numPicross)
      rang = 0
      if Dir.exist?(@dossierImage)
        if File.file?(@fileScenario)
          #inserer dans une pile le scenario
          pileScenario = File.open(@fileScenario).readlines(sep="\n")
          Dir.foreach(@dossierImage){ |x|
            next if x == "." or x == ".."
            if(File.extname(x) != ".txt")
              image = PicrossImage.lire(@dossierImage+x)
              grilleDetat = image.toPicross(10)
              rang = rang+1
              @bd.ajout_aventurePicross(@nomAventure, grilleDetat, pileScenario.shift.chomp("\n"), 10, rang)
            end
          }
        end
      end
    else
      puts("Usage: ./Modele/CreationAventure.rb <nomAventure> <dossier contenant les images> <fichier.txt contenant le scenario>\n")
    end
  end
end
av = CreationAventure.new
