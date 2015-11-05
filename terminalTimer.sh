# script to create timer in terminal
# Jason Atwood
# 2013/6/22
#!/bin/sh

# start up 
echo "starting timer script ..." 
sleep 1 # seconds

# get input from user
read -p "Timer for how many minutes?" -e DURATION
DURATION=$(( $DURATION*60 )) # convert minutes to seconds

# get start time
START=$(date +%s)

# infinite loop
while [ -1 ]; do
	clear					# clear window

	# do math	
	NOW=$(date +%s)				# get time now in seconds
	DIF=$(( $NOW-$START ))			# compute diff in seconds
	ELAPSE=$(( $DURATION-$DIF ))		# compute elapsed time in seconds
	MINS=$(( $ELAPSE/60 ))			# convert to minutes... (dumps remainder from division)
	SECS=$(( $ELAPSE - ($MINS*60) )) 	# ... and seconds

	# conditional
	if [ $MINS == 0 ] && [ $SECS == 0 ]	# if mins = 0 and secs = 0 (i.e. if time expired)
	then 					# blink screen
		for i in `seq 1 180`;    		# for i = 1:180 (i.e. 180 seconds)
		do
			clear					# flash on
			setterm -term linux -back red -fore white # use setterm to change background color
			echo "00:00                             		" # extra tabs for visibiltiy

			sleep 0.5

			clear					# flash off
			setterm -term linux -default		# clear setterm changes from above 
			echo "00:00" 				# (i.e. go back to white text on black background)
			sleep 0.5	
		done  					# end for loop 
		break					# end script

	else 					# else, time is not expired
		echo "$MINS:$SECS"			# display time
		sleep 1  				# sleep 1 second
	fi					# end if
done	# end while loop	
