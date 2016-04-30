##
# Auteur Luc FONTAINE
# Version 1.0
# Date : 29/01/2016
# Description : fichier contenant la class Timer du Picross



#
# Timer, le chronomètre du Picross
# * *Variable*	:
#    - +accumulated+ ->  Le temps accumulé  (seconde)
#    - +elapsed+ -> Le temps écoulé entre t0 et t1
#	 - +start+ -> Variable du temps

# * *Heritage*	: Aucun lien
#

class Timer

  #Le temps accumulé  (seconde)
  @accumulated
  #Le temps écoulé entre t0 et t1
  @elapsed
  #Variable du temps
  @start

  attr_reader :accumulated, :elapsed

  # * *Description*:
	#
	#  Méthode de lancement du Timer et initialisation
	#
	# * *Paramètre*:
	#
	# - +secStart+ -> Le temps de d'initialisation que l'on souhaite pour l'amorçage du Timer en seconde
	#
	# * *Exemple*:
	#
	# unTimer.start(0)
	#
  def start (secStart)
    @accumulated = secStart
    @elapsed = 0
    @start = Time.now
	self
  end

  # * *Description*:
	#
	#  Méthode de pause du Timer
	#
	# * *Exemple*:
	#
	# unTimer.stop
	#
  def stop
    @accumulated += @elapsed
  end

   # * *Description*:
	#
	#  Méthode de remise à zero du Timer
	#
	# * *Exemple*:
	#
	# unTimer.reset
	#
  def reset
    stop
    @accumulated = 0
    @elapsed = 0
	@start = Time.now
  end

    # * *Description*:
	#
	#  Méthode qui permet d'ajouter un nombre de seconde de "pénalité"
	#
	# * *Paramètre*:
	#
	# - +s+ -> temps en seconde que l'on souhaite ajouter au Timer
	#
	# * *Exemple*:
	#
	# unTimer.penalite(10)
	#
  def penalite (s)
    @accumulated = @accumulated+s
  end

   # * *Description*:
	#
	#  Méthode qui calcule le temps passé et le renvoie
	#

  def tick
    @elapsed = Time.now - @start
    time = @accumulated + @elapsed
    h = sprintf('%02i', (time.to_i / 3600))
    m = sprintf('%02i', ((time.to_i % 3600) / 60))
    s = sprintf('%02i', (time.to_i % 60))
    mt = sprintf('%02i', ((time - time.to_i)*100).to_i)
    ms = sprintf('%04i', ((time - time.to_i)*10000).to_i)
    ms[0..0]=''
  #  newtime = "#{h}:#{m}:#{s}.#{mt}.#{ms}"
  #  newtime = "#{h}:#{m}:#{s}.#{mt}"
    newtime = "#{h}:#{m}:#{s}"
  end
end #Fin de la classe Timer



######TEST#######
#watch = Timer.new
#watch.start(0)
#while (sleep 0.2) do
#  puts watch.tick
#end
