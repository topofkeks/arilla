li a0, 0x100	#  100
li a1, -0x100	#  ff00
add a0, x0, a0	#  100
add a1, x0, a1	#  ff00
add a2, a0, a1	#  0
fence 1,1
