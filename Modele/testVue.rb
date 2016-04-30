##
# Auteur YANN GUENVER
# Version 0.1
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant le test de la classe Vue

load "./Controleur/ControleurLogin.rb"
require_relative 'BaseDonnee'
#require 'rubygems'
require 'gtk2'

class Picross

	@bd
	@controleur
	attr_accessor :bd, :controleur

	private_class_method :new

	def Picross.creer
		new
	end

	def initialize
		Gtk.init

		@bd = BaseDonnee.new
		@controleur=ControleurLogin.creer(self)
		Gtk.main
	end
end

jeu=Picross.creer
