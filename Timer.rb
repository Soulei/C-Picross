#Auteur : Luc FONTAINE
#Classe Timer.rb
#Description : chronometre


class Timer

  @accumulated
  @elapsed
  @start


  # == Description
	#
	# Méthode de lancement du Timer
	#
  def start (secStart)
    @accumulated = secStart unless @accumulated
    @elapsed = 0
    @start = Time.now
  end

  # == Description
  #
  # Méthode qui permet de stopper le Timer
  #
  def stop
    @accumulated += @elapsed
  end

  # == Description
  #
  # méthode d'initialisation d'un chronomètre
  #
  def reset
    stop
    @accumulated = 0
    @elapsed = 0

  end

  # == Description
  #
  # méthode d'initialisation d'un chronomètre
  #
  def toSec
    sec = (time.to_i % 60)
  end

  # == Description
  #
  # Méthode de comparaison
  #
  def toCompare (temps)

  end
  # == Description
  #
  # Méthode qui permet d'ajouter un nombre de seconde de "pénalité"
  #
  def penalite (s)
    @accumulated = @accumulated+s
  end

  # == Description
  #
  # Méthode qui calcule le temps passé et l'affiche
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
watch = Timer.new
watch.start(0)
while (sleep 0.2) do
  puts watch.tick
end
