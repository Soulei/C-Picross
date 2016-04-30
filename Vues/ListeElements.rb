
# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur HAJIR Mohammed Amine
# Version 0.1 : Date : 19 03 2016
#

TAILLE = 0;
NOM = 1;
DATE  = 2;
SCORE = 2;

class ListeElements
  
      @listeDeroulante
      @selection
      @@afficheScore

      attr_reader :listeDeroulante, :selection, :afficheScore
              
      def initialize(liste, afficheScore)

            @afficheScore = afficheScore

            affichage = Gtk::TreeView.new()

            if @afficheScore then
	  modele = Gtk::ListStore.new(Integer, String, Integer)
            elsif !@afficheScore then
	  modele = Gtk::ListStore.new(Integer, String, String)
            else
	  puts "[ListeElements]Erreur: Le boolen decidant l'affichage du score ou de la date est incorrect"
      end
    
      @listeDeroulante = Gtk::ScrolledWindow.new()
    
      parametrerAffichage(affichage, modele)
    
      liste.each_with_index do |e, i|

            reference = modele.append

             modele.set_value(reference, TAILLE, liste[i][0])
             modele.set_value(reference, NOM, liste[i][1])
             
             if @afficheScore then
	  modele.set_value(reference, DATE, liste[i][2])
             elsif !@afficheScore then
	  modele.set_value(reference, SCORE, liste[i][2].asctime())
             end
      end
    
      affichage.model = modele

      @listeDeroulante.add(affichage)
      @listeDeroulante.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
    
  end

  
      def triable(colonne, colonne_id)

            colonne.sort_indicator = true
            colonne.sort_column_id = colonne_id

            colonne.signal_connect('clicked') do |w|

              puts "> Ordre colonne " + colonne.title() + " inverse"
              w.sort_order == Gtk::SORT_ASCENDING ? Gtk::SORT_DESCENDING : Gtk::SORT_ASCENDING
            end

      end

      def parametrerAffichage(affichage, modele)

            rendreRouge = Gtk::CellRendererText.new
            rendreRouge.foreground = "#ff0000"

            rendreNoir = Gtk::CellRendererText.new()

            colonneTaille = Gtk::TreeViewColumn.new("Taille", rendreRouge,  :text => TAILLE)
            colonneNom = Gtk::TreeViewColumn.new("Nom", rendreNoir, :text => NOM)

            if @afficheScore then
	  colonneScore = Gtk::TreeViewColumn.new("Score", rendreNoir, :text => SCORE)
            elsif !@afficheScore then
	  colonneDate = Gtk::TreeViewColumn.new("Date", rendreNoir, :text => DATE)
            end

            self.triable(colonneTaille, TAILLE)
            self.triable(colonneNom, NOM)

            if @afficheScore then
	  self.triable(colonneScore, SCORE)
            elsif !@afficheScore then
	  self.triable(colonneDate, DATE)
            end

            affichage.append_column(colonneTaille)
            affichage.append_column(colonneNom)

            if @afficheScore then
	  affichage.append_column(colonneScore)
            elsif !@afficheScore then
	  affichage.append_column(colonneDate)
            end
      end
  
  
      def widget()

            return @listeDeroulante

      end
  
  
      def selectionCourante()

            if widget.child.selection.selected() != nil then
	  return @selection = widget.child.selection.selected[1]
            elsif widget.child.selection.selected() == nil then
	  return nil
            else
	  puts "[ListeElements]Erreur: Mauvaise reception de la selection courante"
            end
      end
  
      def tailleSelectionCourante()

            if widget.child.selection.selected() != nil then
	  return @selection = widget.child.selection.selected[0]
            elsif widget.child.selection.selected() == nil then
	  return nil
            else
	  puts "[ListeElements]Erreur: Mauvaise reception de la selection courante"

            end
      end
  
end

