##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : samedi 23 Janvier 2016
# Description : fichier contenant la classe Pile du jeu Picross

require_relative 'CoupCroix'

#
# Pile, objet modélisant un conteneur de type Pile
# * *Variable*	:
#    - +pile+ -> tableau modélisant la pile
#    - +hyp+ -> entier représentant le nombre de coup jouer en mode hypothèse
#    - +flag+ -> booléen valant vrai si le mode hypothèse est activé, faux si non
# * *Heritage*	: Aucun lien
#
class Pile

	#tableau modélisant la pile
	@pile 
	#entier représentant le nombre de coup jouer en mode hypothèse
	@hyp
	#booléen valant vrai si le mode hypothèse est activé, faux si non
	@flag
	
	#la pile est accessible pour permettre de faire la rétrospective
	attr_reader :hyp, :flag, :pile
	private_class_method :new
	
	# * *Description*:
	# 
	# méthode de création d'une pile
	#
	# * *Retourne* :
	#
	# la Pile nouvellement créée
	#
	# * *Exemple*:
	#
	# unePile=Pile.creer()
	#
	def Pile.creer()
		new()
	end

	def initialize()
		@pile=Array.new()
		@hyp=0
		@flag=false
	end
	
	# * *Description*:
	# 
	# méthode retournant le sommet de la pile sans le retirer
	#
	# * *Retourne* :
	#
	# l'objet au sommet de la pile
	#
	# * *Exemple*:
	#
	# unObjet=unePile.sommet()
	#
	def sommet()
		return @pile.last
	end
	
	
	# * *Description*:
	# 
	# méthode retournant la taille de la pile
	#
	# * *Retourne* :
	#
	# la taille de la pile, i.e. le nombre d'objet dans la pile
	#
	# * *Exemple*:
	#
	# uneTaille=unePile.taille()
	#
	def taille()
		return @pile.length
	end
	
	# * *Description*:
	# 
	# méthode testant si la pile est vide
	#
	# * *Retourne* :
	#
	# un booléen true si la pile est vide, false si non
	#
	# * *Exemple*:
	#
	# unBooleen=unePile.estVide?()
	#
	def estVide?()
		return @pile.empty?
	end
	
	# * *Description*:
	# 
	# méthode remettant la pile a vide (et supprime les objets ??)
	#
	# * *Exemple*:
	#
	# unePile.viderPile()
	#
	def viderPile!()
		@pile.clear
		return self
	end
	
	# * *Description*:
	# 
	# méthode permettant d'activer le mode hypothèse
	#
	# * *Exemple*:
	#
	# unePile.activerHypothese
	#
	def activerHypothese
		@flag=true
	end
	
	# * *Description*:
	# 
	# méthode permettant de valider les coup joué dans le mode hypothèse
	#
	# * *Exemple*:
	#
	# unePile.validerHypothese
	#
	def validerHypothese
		@flag=false
		@hyp=0
	end
	
	# * *Description*:
	# 
	# méthode retirant et retournant le Coup au sommet de la pile, annule l'action du coup en le retirant
	#
	# * *Retourne* :
	#
	# le coup au sommet de la pile
	#
	# * *Exemple*:
	#
	# unCoup=unePile.depiler()
	#
	def depiler()
		unless self.estVide?
			#annule l'action du coup
			self.sommet.annuler
			#renvoie le coup
			if @flag==true
				@hyp-=1
			end
			return @pile.pop
		end
		puts "plus de coup a annuler !"
		return self
	end
	
	
	# * *Description*:
	# 
	# méthode permettant d'ajouter un coup dans la pile
	#
	# * *Paramètre*:
	#
	# - +unCoup+ -> coup que l'on souhaite empiler
	#
	# * *Retourne* :
	#
	# la pile de coup
	#
	# * *Exemple*:
	#
	# unePileDeCoup.empiler(unCoup)
	# 
	def empiler(unCoup)
		if(unCoup.class==Coup || unCoup.class==CoupCroix)
			@pile.push(unCoup)
			@hyp+=1 if @flag==true
		else
			puts "l'objet a empiler n'est pas de class Coup"
		end
		return self
	end
	
	# * *Description*:
	# 
	# méthode remettant la pile a vide et annulant tout les coup qu'elle contenait
	#
	# * *Exemple*:
	#
	# unePile.viderPile()
	#
	def annulerTout!()
		self.depiler while self.estVide? != true
		return self
	end
	
	def annulerHyp
		if @flag==true && @hyp>0 && (!self.estVide?)
			while @hyp >0
				#annule l'action du coup
				self.sommet.annuler
				@pile.pop
				@hyp-=1
			end
			@flag=false
		else
			puts "vous avez annule tout les coups de l'hypothese, annulez la pile classique pour poursuivre l'anulation" 
		end
		return self
	end
	
	# * *Description*:
	# 
	# méthode permettant de construire une pile à partir des données d'un tableau, le tableau sera de la forme suivante : tab[0] le nombre de coup à empiler, tab[1] est un tableau contenant les couples de coordonnées de tout les éléments de la future pile, le champs tab[2] contient les champs oldEtat, tab[3] contient le champs newEtat
	#
	# * *Paramètre*:
	#
	# - +uneGrille+ -> grille où sont joués les coups
	# - +unTableau+ -> tableau contenant les informations sur les coups à jouer pour remplir la pile
	#
	# * *Exemple*:
	#
	# unePileDeCoup.pileCharger(maGrille,leTableau)
	#
	def pileCharger(uneGrille,unTableau)
		#Coup.nouveau(uneCase,old,unePileDeCoup,uneGrille)
		unTableau[0].times{ |entier|
			if unTableau[3][entier]!=2 
				Coup.nouveau(uneGrille.matrice[(unTableau[1][entier][0])][(unTableau[1][entier][1])],unTableau[2][entier],self,uneGrille)
			else
				CoupCroix.nouveau(uneGrille.matrice[(unTableau[1][entier][0])][(unTableau[1][entier][1])],unTableau[2][entier],self,uneGrille)
			end
		}
	end
end
