##
# Auteur SOULEIMAN IMAN Choukri & ESSIA Yannick
# Version 0.1
# Date : Lundi 11 Janvier 2016
# Description : fichier contenant la classe CreationBaseDonnee du jeu du Picross

require 'rubygems'
require 'sqlite3'

#Classe permettant de créer la base de donnée et les tables qui y sont associées
# * *Variables*	:
#    - +valeur+ -> description de la valeur
# * *Heritage*	: Aucun lien
#
class CreationBaseDonnee

  def initialize
    begin
      File.delete("database.db") if File.exists?"database.db"
      db = SQLite3::Database.new("database.db")
      db.execute("CREATE TABLE IF NOT EXISTS Joueur(
        id_joueur INTEGER PRIMARY KEY NULL,
        pseudo TEXT
      )")
      db.execute("CREATE TABLE IF NOT EXISTS Score(
        id_score INTEGER PRIMARY KEY,
        mode TEXT,
        taille INTEGER NULL,
        nomAventure TEXT NULL,
        nomGrille TEXT NULL,
        premier_score INTEGER NULL,
        second_score INTEGER NULL,
        id_joueur INTEGER,
        FOREIGN KEY(id_joueur) REFERENCES Joueur(id_joueur)
      )")
      db.execute("CREATE TABLE IF NOT EXISTS Aventure(
        id_aventure INTEGER PRIMARY KEY,
        nom_aventure TEXT,
        nombre_picross INTEGER
      )")
      db.execute("CREATE TABLE IF NOT EXISTS Grille(
      id_grille INTEGER PRIMARY KEY,
      nom_grille TEXT NULL,
      matrice_grille TEXT,
      scenario TEXT NULL,
      taille_grille INTEGER,
      rang_grille INTEGER NULL,
      id_joueur INTEGER NULL,
      id_aventure INTEGER NULL,
      FOREIGN KEY(id_joueur) REFERENCES Joueur(id_joueur),
      FOREIGN KEY(id_aventure) REFERENCES Aventure(id_aventure)
      )")
      db.execute("CREATE TABLE IF NOT EXISTS PileCoups(
        id_pileCoups INTEGER PRIMARY KEY,
        case_coup TEXT,
      	oldEtat TEXT,
      	newEtat TEXT,
      	coordonnee TEXT,
        nom_partie TEXT
      )")

      db.execute("CREATE TABLE IF NOT EXISTS Partie(
        id_partie INTEGER PRIMARY KEY,
        nom_partie TEXT,
        matrice_tmp TEXT,
        taille_matrice INTEGER,
        id_pileCoups INTEGER,
        temps_joueur INTEGER,
        nb_revelation INTEGER,
        id_grille INTEGER NULL,
        id_joueur INTEGER,
        modeJeu INTEGER,
        rang INTEGER,
        FOREIGN KEY(id_pileCoups) REFERENCES PileCoups(id_pileCoups),
        FOREIGN KEY(id_grille) REFERENCES Grille(id_grille),
        FOREIGN KEY(id_joueur) REFERENCES Joueur(id_joueur)
      )")



    end
  end

end

db = CreationBaseDonnee.new
