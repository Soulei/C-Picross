#Auteur : Luc FONTAINE
#Classe Timer.rb
#Description


class Timer
	#variable intance, correspond au temps en seconde du chronometre
	@temps
	@label
	@thread
	
	attr_reader :temps
	attr_writer :label
	
	
	# == Description
	#
	# méthode d'initialisation d'un chronomètre
	#
	def initialize()
		@temps=0;
	end
	
	
	def startTimer
	
		@thread = Thread.start{
			while true
				sleep 1
				@temps +=1
				setLabel
			end
		}
	
	end
	
	def stopTimer
	
		@thread.kill
	end
	
	
	def setLabel
		@label.set_label(to_s)
		@label.show
	end
	
	
	def to_s
			h = @temps/3600
			m = (@temps - (h*3600)) / 60
			s = @temps - (h*3600) - (m*60)
			
			hh = h < 10 ? "0" + h.to_s : h.to_s
			mm = m < 10 ? "0" + m.to_s : m.to_s
			ss = s < 10 ? "0" + s.to_s : s.to_s
			
		return hh + ":" + mm + ":" + ss
	end
	
	
	
	

end #fin de la classe chrono

t = Timer.new 
t.startTimer
print (t.label)
sleep 5
t.stopTimer

