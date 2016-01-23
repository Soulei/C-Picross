load "Pile.rb"

class Verif
	def tester
		uneCaseBlanche=Case.creer(0)
		uneCaseNoir=Case.creer(1)
		
		puts "case blanche : " ,uneCaseBlanche.etatFinal
		puts "une case noire : ",uneCaseNoir.etatFinal
		
		uneCaseBlanche.etatCourant=1
		uneCaseNoir.etatCourant=0
		
		puts "case blanche : " ,uneCaseBlanche.etatCourant
		puts "une case noire : ",uneCaseNoir.etatCourant
		
		unePileDeCoup=PileCoup.creer()
		unePileDeCase=PileCase.creer()
		
		puts unePileDeCase.estVide?
		unePileDeCase.empiler(uneCaseBlanche)
		puts unePileDeCase.estVide?
		puts unePileDeCase.sommet.etatFinal
		puts unePileDeCase.depiler.etatFinal
		puts unePileDeCase.estVide?
		
		uneCaseBlanche.etatCourant=0
		unCoup=Coup.nouveau(uneCaseBlanche,1,unePileDeCoup)
		
		puts "case blanche apres coup : " ,uneCaseBlanche.etatCourant
		puts unePileDeCoup.estVide?
		puts unePileDeCoup.taille
		
		unePileDeCoup.depiler
		puts "case blanche apres annulation coup : " ,uneCaseBlanche.etatCourant
		puts unePileDeCoup.estVide?
	end
end

essaie=Verif.new
essaie.tester
