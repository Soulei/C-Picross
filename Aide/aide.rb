#################################
# AIDE  PICROSS                       #
#################################
# Auteur : LAMNIY Youssef
# Version : 1

class Aide

  #Largeur de la grille(x)
  attr :Largeur, true 
  #Hauteur de la grille(y)
  attr :Hauteur, true 
  #Grille de Picross
  attr :GrillePicross, true 
  #Matrice pour les lignes
  attr :TabLignes, true 
  #Matrice pour les colonnes
  attr :TabColonnes, true
  
  attr :LargeurTabL, true
  attr :LongueurTabC, true
  attr :TabAideDispo, true
    
  private_class_method :new
  
  def Aide.scanner(uneGrille)
    new(uneGrille)
  end
  
  def initialize(uneGrille)
    @GrillePicross = uneGrille
    @Largeur = @GrillePicross.taille
    @Hauteur = @GrillePicross.taille
    
    @TabLigne 	= uneGrille.tableLigne
    @TabColonne = uneGrille.tableColonne
    
    @@TabAideDispo1 = Array.new
    @@TabAideDispo2 = Array.new
    
    # scan une bonne fois pour toutes la grille
    # et ensuite, on se sert des aides contenues dans les deux tableaux uniquement
    aideDeNiveau1
  end
  
  
  # appelé par @@TabAideDispo2
  # ligne est soit vrai, soit faux(si c'est sur une colonne)
  
#	def phrasePrecise(technique, ligne, index)
#		return "Vous pouvez appliquer la technique #{technique}\nsur la #{ligne ? "ligne" : "colonne"} #{index}."
#	end

  
  def choisirAuHasard(niveau)
		
		aideTrouvee = "Pas(ou plus) d'aide de niveau(#{niveau}) disponible."
		
		if niveau == 1
			aideTrouvee = @@TabAideDispo1.shuffle!.pop unless @@TabAideDispo1.empty?
		elsif niveau == 2
			aideTrouvee = @@TabAideDispo2.shuffle!.pop unless @@TabAideDispo2.empty?
		else 
			aideTrouvee = "Ce niveau(#{niveau}) n'existe pas encore."
		end
		
		return aideTrouvee
  end
  
  #Définition des aides possible à partir de la matrice TabLignes
  def aideDeNiveau1
    # TABLE LIGNE
    0.upto(@TabLigne.hauteur-1){ |x|
      num_ligne = x + 1
      nombres = @TabLigne.nombresDeLaLigne(x)
      somme = nombres.inject { |val, sum| sum += val }
      val_max = @TabLigne.nombresDeLaLigne(x).max
      val_max = 0 if val_max == nil # cas où la ligne est vide
      if(somme == @Largeur)
        @@TabAideDispo1.push("Regardez à la ligne " + num_ligne.to_s + ",\nVous pouvez colorier toutes les cases !!")
      elsif(somme == @Largeur - 1)
        @@TabAideDispo1.push("Regardez à la ligne " + num_ligne.to_s + "\Facile non ?")
      elsif(val_max > @Largeur / 2)
        @@TabAideDispo1.push("Regardez à la ligne " + num_ligne.to_s + ",\nLa case du milieu est forcement coloriée !!")
      elsif(nombres.size > @Largeur / 2)
        @@TabAideDispo1.push("Regardez à la ligne" + num_ligne.to_s+",\nVous pouvez colorier la premiere case !!")
      end
    }


    # TABLE COLONNE
    0.upto(@TabColonne.hauteur-1){ |x|
      num_colonne = x + 1
      nombres = @TabColonne.nombresDeLaColonne(x)
      somme = nombres.inject { |val, sum| sum += val }
      val_max = @TabColonne.nombresDeLaColonne(x).max
      val_max = 0 if val_max == nil # cas où la colonne est vide
      if(somme == @Hauteur)
        @@TabAideDispo1.push("Regardez à la colonne " + num_colonne.to_s + ",\nVous pouvez colorier toutes les cases !!")
      elsif(somme == @Hauteur-1)
        @@TabAideDispo1.push("Regardez à la colonne " + num_colonne.to_s + "\Facile non ?")
      elsif(val_max > @Hauteur / 2)
        @@TabAideDispo1.push("Regardez à la colonne " + num_colonne.to_s + ",\nLa case du milieu est forcement coloriée !!")
      elsif(nombres.size > @Hauteur / 2)
        @@TabAideDispo1.push("Regardez à la ligne" + num_colonne.to_s+",\nVous pouvez colorier la premiere case !!")
      end
    }

    #@@TabAideDispo1.push("Il n'y a aucune aide dispo") if @@TabAideDispo1.size == 0
    Logs.add(@@TabAideDispo1)
    #return @@TabAideDispo1
  end
  
end
