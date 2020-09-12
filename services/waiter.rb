class Waiter
  def self.wait_for_free_status(sec)
  	sec_from_0 = 0

  	loop do 

  	break if (sec_from_0 == sec) || $status == 'free'
  	  sleep 1
  	  sec_from_0 += 1
  	end
  end
end