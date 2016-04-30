###########################################################################
# -*- encoding: utf-8 -*-
# OUTILS.RB
# définition de types et fonctions communes au fichier picture.rb
# HAJIR MOHAMMED AMINE
###########################################################################


#################################
# TAILLEGRILLE		
#################################
# TailleGrille, pour encapsuler les différentes tailles possibles d'un picross dans un seul tableau
# toutes les tailles possibles sont référencées dans cette classe
#
# * *Variable*	:
#    - +tailles+ -> tableau contenant les valeurs des tailles possibles
# * *Heritage*	: Aucun lien
#
class TailleGrille
      @@tailles = [5,10,15,20,25]

      # méthode qui renvoi le tableau des tailles possibles d'une grille picross
      #
      # * *Paramètres* : aucun
      #
      # * *Retourne* :
      #   -le tableau des tailles possibles d'une grille picross
      #
      # * *Raises* : aucune exception
      #
      # * *Exemple* :
      #
      def TailleGrille.tailles() 
            return @@tailles 
      end
end


#################################
# ETAT
#################################
# Etat : On définit l'état d'une case dans cette classe
# trois états sont possibles pour une case : blanc, noir ou drapeau
# 
# * *Variable*	:
#    - +blanc+   -> état d'une case blanche représenté par l'entier 0
#    - +noir+    -> état d'une case noir représenté par l'entier 1
#    - +drapeau+ -> autre état représenté par l'entier 2
# 
# * *Heritage*	: Aucun lien
#
class Etat
      
      @@blanc   = 0
      @@noir    = 1
      @@drapeau = 2
      
       
      # définition des 3 accesseurs aux différents états d'une case
      #
      # * *Paramètres* : 
      #   - +etatCase+ -> l'etat dont on souhaite tester la validité
      #
      # * *Retourne* :
      #   - true si la valeur reçue est un état valide
      #
      # * *Raises* : aucune exception
      # 
      # * *Exemple* :
      #
      
      # Accesseur vers l'état blanc
      def Etat.Blanc() 
            return @@blanc 
      end
     
      # Accesseur vers l'état noir
      def Etat.Noir() 
            return @@noir 
      end
      
      # Accesseur vers l'état drapeau
      def Etat.Drapeau() 
            return @@drapeau 
      end

     
      # méthode qui vérifie si l'état d'une case correspond bien au trois états possibles : blanc, noir ou drapeau 
      #
      # * *Paramètres* : 
      #   - +etatCase+ -> l'etat dont on souhaite tester la validité
      #
      # * *Retourne* :
      #   - true si la valeur reçue est un état valide
      #
      # * *Raises* : aucune exception
      # 
      # * *Exemple* :
      #
      def Etat.include?(etatCase)
            return [@@blanc, @@noir, @@drapeau].include? etatCase
      end

      # méthode qui permet de renvoyer l'état suivant de celui passé en paramètre
      #
      # * *Paramètres* : 
      #   - +etat+ -> l'état à partir duquel le suivant est renvoyé 
      #
      # * *Retourne* :
      #   - Renvois l'état suivant à celui reçu
      #
      # * *Raises* : Lève une exception si l'état n'est pas valide
      # 
      # * *Exemple* :
      #
      def Etat.suivant(etat)
            # Assertion
            raise "Etat non valide" if not (Etat.include?(etat) and etat != nil)
            # Retour
            if    etat == @@blanc    then return @@noir
            elsif etat == @@noir     then return @@drapeau
            elsif etat == @@drapeau  then return @@blanc
            end
      end

end

