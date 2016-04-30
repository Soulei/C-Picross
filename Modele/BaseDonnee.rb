##
# Auteur SOULEIMAN IMAN Choukri & ESSIA Yannick
# Version 0.1
# Date : Lundi 11 Janvier 2016
# Description : fichier contenant la classe BaseDonnee du jeu de Picross

require 'rubygems'
require 'sqlite3'

require_relative 'Grille_v2'
require_relative 'Jeu'


#Classe permettant de sauvegarder et de charger les informations liées aux joueurs, scores et les données d'une partie
# * *Variables*	:
#    - +PREMIER_SCORE+ -> Constante permettant d'indiquer le type de score
#    - +SECOND_SCORE+ ->Constante permettant d'indiquer le type de score
# * *Heritage*	: Aucun lien
#
class BaseDonnee
  unless (const_defined?(:PREMIER_SCORE))
    PREMIER_SCORE = 0
  end
  unless (const_defined?(:SECOND_SCORE))
    SECOND_SCORE = 1
  end
  unless (const_defined?(:MODE_AVENTURE))
    MODE_AVENTURE = 1
  end
  unless (const_defined?(:MODE_DETENTE))
    MODE_DETENTE = 2
  end
  unless (const_defined?(:MODE_GRILLE_EDIT))
    MODE_GRILLE_EDIT = 3
  end

  attr_reader :MODE_GRILLE_EDIT
  #Permet de vérifier si un pseudo rentrer par un utilsateur n'est pas déjà pris
  #
  # * *Paramètres*:
  #   - +pseudo+ -> pseudo rentrer par un utilsateur
  # * *Retourne* :
  #   -le nombre de ligne contenant le pseudo passé en paramètre
  #* *Exemple* :
  #
  def pseudo_present(pseudo)
    begin
      db = SQLite3::Database.new("database.db")
      res_execute = db.execute("SELECT count(*) from Joueur WHERE pseudo = ?", pseudo)
      return res_execute.flatten.first

    end
  end
  #Permet l'extraction du tableau des scores de la base de donnée
  #
  # * *Paramètres*:
  #   - +mode+ -> le type du mode (Detente, Aventure ou Editeur)
  #   - +taille+ -> taille de la grille deans le cas du mode de detente
  #   - +type_score+ -> le type de score
  # => du premier score -  0
  # => ou
  # => le second score - 1
  # * *Retourne* :
  # => un tableau contenant les joueurs et leurs scores respectifs
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def extract_score(mode, taille, type_score)
    begin
      db = SQLite3::Database.new("database.db")
      if(mode == MODE_DETENTE)
        res_execute = db.execute("SELECT pseudo, premier_score from Joueur JOIN Score using(id_joueur) WHERE taille = ?", taille)
      elsif(mode == MODE_AVENTURE || mode == MODE_GRILLE_EDIT)
          res_execute = db.execute("SELECT pseudo, premier_score from Joueur JOIN Score using(id_joueur) WHERE mode = ? and nom = ? and type_score = ?", mode, nom, type_score)
      end
      return res_execute.flatten()
    end
  end
  #Permet de sauvegarder le score d'un joueur pour une partie donnée
  #
  # * *Paramètres*:
  #   - +score_final+ -> score final du joueur
  #   - +pseudo+ -> pseudo du joueur
  #   - +type_score+ -> définit si le score à sauvegarder s'agit
  # => du premier score -  0
  # => ou
  # => le meilleur score - 1
  #   - +mode+ -> le type de mode
  #   - +taille+ -> taille de la grille deans le cas du mode de detente
  #   - +nom+ -> il s'agit soit du nom de l'aventure dans le cas du mode Aventure, soit le nom de la grille dans le cas du mode Editeur
  # * *Retourne* :
  #   -vrai si l'opération d'insertion dans la base de donnée s'est correctement efféctuée
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def save_score(score_final, pseudo, type_score,mode, taille, nom)
    begin
      db = SQLite3::Database.new("database.db")
      res_id_joueur = db.execute("SELECT id_joueur from Joueur WHERE pseudo = ?", pseudo)
      id_j = res_id_joueur[0]
      if(mode == MODE_DETENTE)
        res_execute = db.execute("INSERT INTO Score (mode,taille,premier_score,id_joueur) VALUES(?, ?, ?, ?)",mode, taille, score_final,id_j)
      elsif(mode == MODE_AVENTURE || mode == MODE_GRILLE_EDIT)
        if(type_score == PREMIER_SCORE)
          res_execute = db.execute("INSERT INTO Score (mode, nomAventure,premier_score,id_joueur) VALUES(?, ?, ?, ?)",mode, nom, score_final,id_j)
        elsif(type_score == SECOND_SCORE)
          res_execute = db.execute("INSERT INTO Score (mode, nomGrille,second_score,id_joueur) VALUES(?, ?, ?, ?)",mode, nom, score_final, id_j)
        end
      end
    end
  end

  #Permet de savoir si un joueur a precedemment terminé une aventure ou une grille personnalisé
  #
  # * *Paramètres*:
  #   - +pseudo+ -> pseudo du joueur
  #   - +mode+ -> le type du mode (Detente, Aventure ou Editeur)
  #   - +nom+ -> il s'agit soit du nom de l'aventure dans le cas du mode Aventure, soit le nom de la grille dans le cas du mode Editeur
  # * *Retourne* :
  #   -vrai si l'opération d'insertion dans la base de donnée s'est correctement efféctuée
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def scorePremier_present?(pseudo, mode, nom)
    begin
      db = SQLite3::Database.new "database.db"
      res_execute = db.execute("SELECT count(*) FROM Score JOIN Joueur using(id_joueur) WHERE pseudo = ? and mode = ? and nom = ?", pseudo, mode, nom)
      return res_execute.flatten.first
    end
  end
  #Permet de sauvegarder le pseudo d'un joueur
  #
  # * *Paramètres*:
  #   - +pseudo+ -> pseudo du joueur
  # * *Retourne* :
  #   -vrai si l'opération d'insertion dans la base de donnée s'est correctement efféctuée
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def save_pseudo(pseudo)
    begin
      db = SQLite3::Database.new "database.db"
      res_execute = db.execute("INSERT INTO Joueur (pseudo) VALUES (?)",pseudo)
    end
  end
  #Permet de extraire la pile de coups
  #
  # * *Paramètres*:
  #   - +pseudo+ -> pseudo du joueur
  # * *Retourne* :
  #   -vrai si l'opération d'insertion dans la base de donnée s'est correctement efféctuée
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def process_pile_coupsCharger(pile_coups)

    oldEtat = pile_coups[2].split(",").map(&:to_i).to_a
    newEtat = pile_coups[3].split(",").map(&:to_i).to_a
    coordonnee = pile_coups[4].split(",").map(&:to_i).each_slice(2).to_a
    return [coordonnee.length, coordonnee, oldEtat, newEtat]
  end

  def process_pile_coupsSave(pile_coups)

    coup = pile_coups.depiler()
    case_p = coup.case.etatFinal.to_s+","+coup.case.etatCourant.to_s
    oldEtat = coup.oldEtat.to_s
    newEtat = coup.newEtat.to_s
    coordonnee = coup.case.abscisse.to_s+","+coup.case.ordonne.to_s

    while(!pile_coups.estVide?) do
      coup = pile_coups.depiler()
      case_p = coup.case.etatFinal.to_s+","+coup.case.etatCourant.to_s+","+case_p
      oldEtat = coup.oldEtat.to_s+","+oldEtat
      newEtat = coup.newEtat.to_s+","+newEtat
      coordonnee = coup.case.abscisse.to_s+","+coup.case.ordonne.to_s+","+coordonnee
    end
    res = [case_p, oldEtat, newEtat, coordonnee]
    return res
  end
  #Permet de sauvegarder une partie
  #
  # * *Paramètres*:
  #   - +pseudo+ -> pseudo du joueur
  # * *Retourne* :
  #   -vrai si l'opération d'insertion dans la base de donnée s'est correctement efféctuée
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def process_grille(grille)
    tmp = grille.matrice
    res = tmp.flatten.join(",")
    return res
  end
  #Permet de sauvegarder une partie
  #
  # * *Paramètres*:
  #   - +pseudo+ -> pseudo du joueur
  #   - +nom_partie+ -> nom de la partie à sauvegarder
  #   - +temps_joueur+ -> temps en secondes du joueur à sauvegarder
  #   - +pile_coups+ -> pile contenant les coups joués
  #   - +grille+ -> grille du jeu à sauvegarder
  #   - +nb_revelation+ -> nombre d'aides utilisés par le joueur pendant cette partie
  #   - +nom_grille+ -> nom de la grille à sauvegarder
  #   - +mode+ -> mode du jeu
  #   - +nom_aventure+ -> nom du mode aventure
  # * *Retourne* :
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def save_partie(pseudo, nom_partie , temps_joueur, pile_coups, grille, nb_revelation, nom_grille, mode, rang, nom_aventure)
    res_pile = process_pile_coupsSave(pile_coups)
    res_matrice = process_grille(grille)
    begin
      db = SQLite3::Database.new("database.db")
      res_id_joueur = db.execute("SELECT id_joueur from Joueur WHERE pseudo = ?", pseudo)
      id_j = res_id_joueur.flatten.first
      #Verifier si la partie a enregistree est la même partie et du même joueur
      res_nbPartie = db.execute("SELECT count(*) FROM Partie WHERE id_joueur = ? and nom_partie = ?", id_j, nom_partie)
      if(res_nbPartie.flatten.first >= 1)
        db.execute("DELETE FROM Partie WHERE id_joueur = ? and nom_partie = ?", id_j, nom_partie)
        db.execute("DELETE FROM PileCoups WHERE nom_partie = ?", nom_partie)
      end
      res_execute = db.execute("INSERT INTO PileCoups (case_coup, oldEtat, newEtat, coordonnee, nom_partie) VALUES(?, ?, ?, ?, ?)",res_pile[0], res_pile[1], res_pile[2], res_pile[3], nom_partie)
      res_id_pileCoups = db.execute("SELECT id_pileCoups from PileCoups WHERE nom_partie = ?", nom_partie)
      id_p = res_id_pileCoups.flatten.first

      if(mode == MODE_GRILLE_EDIT)
        res_id_grille = db.execute("SELECT id_grille from Grille WHERE nom_grille = ?", nom_grille)
        id_g = res_id_grille.flatten.first
        res_execute = db.execute("INSERT INTO Partie (nom_partie,matrice_tmp,taille_matrice, id_pileCoups,temps_joueur,nb_revelation,id_grille,id_joueur, modeJeu) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)",nom_partie,res_matrice, grille.largeur, id_p, temps_joueur, nb_revelation, id_g, id_j, mode)
      elsif(mode == MODE_AVENTURE)
        res_id_grille = db.execute("SELECT id_grille from Aventure JOIN Grille using(id_aventure) WHERE nom_aventure = ? and rang_grille = ?", nom_aventure, rang)
        id_g = res_id_grille.flatten.first
        res_execute = db.execute("INSERT INTO Partie (nom_partie,matrice_tmp,taille_matrice, id_pileCoups,temps_joueur,nb_revelation,id_grille, id_joueur, modeJeu, rang) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",nom_partie,res_matrice, grille.largeur, id_p, temps_joueur, nb_revelation, id_g, id_j, mode, rang)
      else
        res_execute = db.execute("INSERT INTO Partie (nom_partie,matrice_tmp, taille_matrice, id_pileCoups,temps_joueur,nb_revelation,id_joueur, modeJeu) VALUES(?, ?, ?, ?, ?, ?, ?, ?)",nom_partie,res_matrice, grille.largeur, id_p, temps_joueur, nb_revelation, id_j, mode)
      end
    end
  end
  #Permet d'extraire et de réorganiser les données obtenues à partie de la base de donnée
  #
  # * *Paramètres*:
  #   - +row_data+ -> tableau contenant les données recueillies à partir de la base de donnée
  # * *Retourne* :
  #   -un tableau contenant la pile de coups, la matrice, le temps et le nombres d'aides utilisés
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def extract_row_data(row_data)
    matrice = row_data[2].split(",").map(&:to_i).each_slice(Integer(row_data[3])).to_a
    temps = Integer(row_data[5])
    nb_r = Integer(row_data[6])
    return [matrice,temps,nb_r]
  end
  #Permet de charger une partie
  #
  # * *Paramètres*:
  #   - +pseudo+ -> pseudo du joueur
  #   - +nom_partie+ -> nom de la partie à charger
  #   - +mode+ -> mode du jeu de la partie à charger
  # * *Retourne* :
  #   -un tableau contenant  dans le mode detente:
  # => -le mode, la matrice, la pile de coups, le temps, le nombres d'aides utilisés et le mode
  # => -la matrice, la pile de coups, le temps, le nombres d'aides utilisés, le rang de la grille dans l'aventure et le mode
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def charger_partie(pseudo, nom_partie)
    begin
      db = SQLite3::Database.open "database.db"
      res_id_joueur = db.execute("SELECT id_joueur from Joueur WHERE pseudo = ?", pseudo)
      id_j = res_id_joueur.flatten.first
      res_partie = db.execute("SELECT * FROM Partie where id_joueur = ? and nom_partie = ?", id_j, nom_partie)
      id_pile = Integer(res_partie.flatten.fetch(4))
      mode = Integer(res_partie.flatten.fetch(9))
      if(mode == MODE_GRILLE_EDIT)
        id_grille = Integer(res_partie.flatten.fetch(7))
      end
      res_pile = db.execute("SELECT * FROM PileCoups where id_pileCoups = ?", id_pile)
      res_pileCoup = process_pile_coupsCharger(res_pile[0])
      res_final = extract_row_data(res_partie.flatten(1))
      if(mode == MODE_AVENTURE)
        #recuperer le nom de l'aventure
        nom_aventure = db.execute("SELECT nom_aventure FROM Aventure JOIN Grille using(id_aventure) WHERE id_grille = ?", id_grille)
        res_rang = Integer(res_partie.flatten.fetch(10))
        return res_final.insert(1, res_pileCoup).insert(4, res_rang).insert(5, mode).insert(6, nom_aventure.flatten)
      elsif(mode == MODE_GRILLE_EDIT)
        nom_grille = db.execute("SELECT nom_grille FROM Partie JOIN Grille using(id_grille) WHERE id_grille = ?", id_grille)
        return res_final.insert(1, res_pileCoup).insert(5, mode).insert(6, nom_grille.flatten)
      elsif (mode == MODE_DETENTE)
        return res_final.insert(1, res_pileCoup).insert(5, mode)
      end
    end
  end
  #Permet de sauvegarder une grille personnaliée par l'utilisateur : générée à partir d'une image
  #
  # * *Paramètres*:
  #   - +matrice+ -> objet de type GrilleImage contenant la matrice à sauvegarder
  #   - +taille_matrice+ -> taille de la matrice
  #   - +nom_matrice+ -> nom de la matrice
  #   - +rang_grille+ -> rang de la matrice dans le cas d'un mode aventure et 0 sinon
  #   - +taille_grille+ -> taille de la matrice
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def save_grillePersonnalisee(pseudo, matrice, taille_matrice, nom_matrice)
    begin
      db = SQLite3::Database.new("database.db")
      res_id_joueur = db.execute("SELECT id_joueur from Joueur WHERE pseudo = ?", pseudo)
      id_j = res_id_joueur.flatten.first
      matrice = matrice.flatten.join(",")
      #Grille appartenant au mode Grille Utilisateur
      res_execute = db.execute("INSERT INTO Grille (nom_grille,matrice_grille,taille_grille,id_joueur) VALUES(?, ?, ?, ?)",nom_matrice,matrice,taille_matrice, id_j)
      end
  end
  #Permet de charger une grille personnaliée par l'utilisateur ou générée à aprtie d'une image
  #
  # * *Paramètres*:
  #   - +nom_grille+ -> nom de la grille à charger
  # * *Retourne* :
  #   -une matrice représentant le picross
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def charge_grillePersonnalisee(nom_grille)
    begin
      db = SQLite3::Database.open "database.db"
      res_taille = db.execute("SELECT taille_grille FROM Grille where nom_grille = ?", nom_grille)
      taille_g = res_taille.flatten.first
      res = db.execute("SELECT matrice_grille FROM Grille where nom_grille = ?", nom_grille)
      res_row = res[0]
      matrice = res_row[0].split(",").map(&:to_i).each_slice(taille_g).to_a
      return matrice
    end
  end
  #Permet de charger les noms des grilles du mode Grille Edit
  #
  # * *Paramètres*:
  # => -pseudo : pseudo du joueur
  # * *Retourne* :
  #   -un tableau contenant les noms du mode Grille Edit
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def nomsGrilleEdit(pseudo)
    begin
      db = SQLite3::Database.open "database.db"
      res = db.execute("SELECT nom_grille FROM Grille JOIN Joueur using(id_joueur) WHERE pseudo IS NOT ?", pseudo)
      if res[0] != nil
        res.each{|x| puts x}
      end
      return res[0]
    end
  end
  #Permet de charger les noms des grilles sauvegarder par un utilsateur donné
  #
  # * *Paramètres*:
  #   - +pseudo+ -> pseudonyme d'un joueur
  # * *Retourne* :
  #   -un tableau contenant les noms des grilles sauvegarder par un utilsateur donné
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def nomsParties_Sauvegarde(pseudo)
      begin
        db = SQLite3::Database.open "database.db"
        res_id_joueur = db.execute("SELECT id_joueur from Joueur WHERE pseudo = ?", pseudo)
        id_j = res_id_joueur[0]
        res = db.execute("SELECT nom_partie, modeJeu FROM Partie WHERE id_joueur = ?", id_j)
        if(res[0] != nil)
          return res
        else
          return res
        end
      end
  end

  #Permet d'ajouter une aventure à la base de donnée
  #
  # * *Paramètres*:
  #   - +nom_aventure+ -> nom de l'aventure en question
  #   - +nombre_picross+ -> nombre de picross propre à l'aventure en question
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def ajout_aventure(nom_aventure, nombre_picross)
    begin
      db = SQLite3::Database.open "database.db"
      res_execute = db.execute("INSERT INTO Aventure (nom_aventure, nombre_picross) VALUES(?, ?)",nom_aventure, nombre_picross)
    end
  end

  #Permet d'ajouter un picross obtenu à partir d'une image à une aventure donnée
  #
  # * *Paramètres*:
  #   - +nom_aventure+ -> nom de l'aventure en question
  #   - +matrice+ -> matrice résultant de la pixelisation d'une image
  #   - +taille_matrice+ -> taille de la matrice
  #   - +rang_grille+ -> rang de la matrice dans le cas d'un mode aventure et 0 sinon
  #   - +taille_grille+ -> taille de la matrice
  # * *Raises* :
  #   - +name_exception+ ->
  #* *Exemple* :
  #
  def ajout_aventurePicross(nom_aventure, matrice, scenario, taille_matrice, rang_grille)
    begin
      db = SQLite3::Database.open "database.db"
      res_id_aventure = db.execute("SELECT id_aventure from Aventure WHERE nom_aventure = ?", nom_aventure)
      id_a = res_id_aventure[0][0]
      matrice = matrice.flatten.join(',')
      res_execute = db.execute("INSERT INTO Grille (matrice_grille,scenario,taille_grille,rang_grille,id_aventure) VALUES(?, ?, ?, ?, ?)",matrice,scenario,taille_matrice, rang_grille, id_a)
    end
  end

  #Permet de charger le picross lié à une aventure
  #
  # * *Paramètres*:
  #   - +nom_aventure+ -> nom de l'aventure en question
  #   - +rang_grille+ -> rang du picross dans l'aventure
  # * *Retourne* :
  #   - un tableau contenant la matrice du picross et le scenario correspondant à cette matrice
  #* *Exemple* :
  #
  def charger_picrossAventure(nom_aventure, rang_grille)
    begin
      db = SQLite3::Database.open "database.db"
      res_id_aventure = db.execute("SELECT id_aventure from Aventure WHERE nom_aventure = ?", nom_aventure)
      id_a = res_id_aventure[0][0]
      res_execute = db.execute("SELECT matrice_grille, taille_grille, scenario FROM Grille WHERE id_aventure = ? AND rang_grille = ?", id_a, rang_grille)
      res_mat = res_execute[0][0]
      taille = res_execute[0][1]
      scenar = res_execute[0][2]
      matrice = res_mat.split(",").map(&:to_i).each_slice(taille).to_a
      res = [matrice, scenar]
      return res
    end
  end
  #Renvoi le nombre de picorss pour une aventure donnée
  #
  # * *Paramètres*:
  #   - +nom_aventure+ -> nom de l'aventure en question
  # * *Retourne* :
  #   - le nombre de picross d'une aventure
  #* *Exemple* :
  #
  def get_nombrePicross(nom_aventure)
    begin
      db = SQLite3::Database.open "database.db"
      res_nb = db.execute("SELECT nombre_picross from Aventure WHERE nom_aventure = ?", nom_aventure)
      return res_nb[0]
    end
  end
  #Permet de retourner le tabelau contenant la liste des aventures
  #
  # * *Paramètres*:
  # * *Retourne* :
  #   - un tableau contenant laes noms des différentes aventures
  #* *Exemple* :
  #
  def nomsAventures()
      begin
        db = SQLite3::Database.open "database.db"
        res = db.execute("SELECT nom_aventure from Aventure")
        return res[0]
      end
  end
end
