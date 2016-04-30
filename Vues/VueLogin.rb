##
# Auteur YANN GUENVER
# Version 0.1
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant la classe VueLogin du jeu du Picross
#encoding: UTF-8

require_relative 'Vue'
require 'gtk2'

# Vue chargée de présenter une interface d'identification
# * *Variables*	:
#
# * *Heritage*	: Vue
#
class VueLogin < Vue

	@etLogin
	@btAccepter

	@btQuitter

	attr_reader :etLogin, :btAccepter, :btQuitter
	private_class_method :new

	def VueLogin.creer()
		new()
	end

	def initialize()

		super("Picross")

		@window.add(creerTable)

		@window.show_all
	end

	# Crée une Table contenant les boutons
	def creerTable

		table = Gtk::Table.new(4, 1, true)

		@etLogin = Gtk::Entry.new
		@btAccepter = Gtk::Button.new("Accepter")
		@btAccepter.set_image(Gtk::Image.new(File.expand_path("./Icons/ok.png", File.dirname(__FILE__))))
		@btAccepter.set_alignment(0.3,0)
		@btQuitter = Gtk::Button.new("Quitter ")
		@btQuitter.set_image(Gtk::Image.new(File.expand_path("./Icons/quit.png", File.dirname(__FILE__))))
		@btQuitter.set_alignment(0.3,0)

		table.attach(Gtk::Label.new("Login"), 0, 1, 0, 1)
		table.attach(@etLogin, 0, 1, 1, 2)
		table.attach(@btAccepter, 0, 1, 2, 3)
		table.attach(@btQuitter, 0, 1, 3, 4)


		return table
	end

end
