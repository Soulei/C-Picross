#Auteur : Luc FONTAINE
#Classe Timer.rb
#Description : Timer


class Timer

  #Le temps accumulé  (seconde)
  @accumulated
  #Le temps écoulé entre t0 et t1
  @elapsed
  #Variable du temps
  @start

  attr_reader :accumulated

  # == Description
	#
	# Méthode de lancement du Timer et initialisation
  #
	# == Paramètres
  #
  # * +secStart+ : Le temps de d'initialisation que l'on souhaite pour l'amorçage du Timer en seconde
  #
  def start (secStart)
    @accumulated = secStart unless @accumulated
    @elapsed = 0
    @start = Time.now
  end

  # == Description
  #
  # Méthode de pause du Timer
  #
  def stop
    @accumulated += @elapsed
  end

  # == Description
  #
  # Méthode de remise à zero du Timer
  #
  def reset
    stop
    @accumulated = 0
    @elapsed = 0

  end

  # == Description
  #
  # Méthode d'initialisation du Timer
  #
  def toSec
    sec = (time.to_i % 60)
  end

  # == Description
  #
  # Méthode de comparaison de deux temps	# == Paramètres
  #
  # * +temps+ : le temps de comparaison
  #
  def toCompare (temps)
    if ( (self.accumulated)>(temps) )
      return 1
    elsif  ( (self.accumulated)<(temps) )
      return -1
    else
      return 0
    end
  end

  # == Description
  #
  # Méthode qui permet d'ajouter un nombre de seconde de "pénalité"
  # == Paramètres
  #
  # * +s+ : temps en seconde que l'on souhaite ajouter au Timer
  #
  def penalite (s)
    @accumulated = @accumulated+s
  end

  # == Description
  #
  # Méthode qui calcule le temps passé et le renvoie
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
  #    newtime = "#{h}:#{m}:#{s}.#{mt}"
    newtime = "#{h}:#{m}:#{s}"
  end
end #Fin de la classe Timer



######TEST#######
#watch = Timer.new
#watch.start(0)
#while (sleep 0.2) do
#  puts watch.tick
#end
