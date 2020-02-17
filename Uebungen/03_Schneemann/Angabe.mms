# Uebung MMIX


\/--------\/-------------DIESEN CODE NICHT VER�NDERN----------\/-----------\/
		LOC		Data_Segment
		GREG	@
		
		#Format der abgespeicherten Positionsdaten: 
		# R: no position data
		# X: x position data
		# Y: y position data
		# Format:
		#		#RRRXXYYR
data	TETRA	#00050100,#00051100,#00052100,#00040200,#00045200,#00050200
		TETRA	#00055200,#00060200,#00065200,#00045300,#00050300,#00055300
		TETRA	#00060300,#00065300,#00070300,#00075300,#00080300,#00025400
		TETRA	#00030400,#00035400,#00040400,#00045400,#00050400,#00055400
		TETRA	#00060400,#00065400,#00035500,#00040500,#00045500,#00050500
		TETRA	#00055500,#00060500,#00065500,#00070500,#00035600,#00040600
		TETRA 	#00045600,#00050600,#00055600,#00060600,#00065600,#00070600

atad	BYTE	"_",0,"_",0,"_",0,"_",0,"|",0,"=",0,"=",0,"|",0,"_",0
		BYTE	"(",0,"'",0,"'",0,")",0,"_",0,"_",0,"/",0," ",0,">",0
		BYTE	"-",0,"-",0,"(",0,"`",0,"^",0,"^",0,"'",0,")",0,"(",0
		BYTE	"`",0,"^",0,"'",0,"^",0,"'",0,"`",0,")",0,"`",0,"=",0
		BYTE	"=",0,"=",0,"=",0,"=",0,"=",0,"'",0
NL		BYTE	10,13,0	
Done	BYTE	"Done",0

		LOC		#100
# Traps
GSetPos 	IS	#24
MWait		IS	#30
FPuts		IS	#07

/\--------/\-------------DIESEN CODE NICHT VER�NDERN----------/\-----------/\

\/--------\/----------------HIER BEGINNT IHR CODE-------------\/-----------\/

		PREFIX :PrintBigPic:

print	SWYM
		
		PREFIX :

/\--------/\-----------------HIER ENDET IHR CODE--------------/\-----------/\

\/--------\/-------------DIESEN CODE NICHT VER�NDERN----------\/-----------\/
param	IS		$0

Main	SWYM
	
		PUSHJ param,PrintBigPic:print

		LDA $255,NL
		TRAP 0,FPuts,StdOut

		LDA $255,Done
		TRAP 0,FPuts,StdOut
		[ENDE DER AUSGABE]
		TRAP 0,Halt,0

----------------------------UNTERPROGRAMM PrintPic----------------------------

		PREFIX :PrintSmallPic:
id		IS		$0
adr		IS		$1

print		SWYM
		SET $255,0
		LDA adr,:atad
		MUL id,id,2
		ADD $255,adr,id

		TRAP 0,:FPuts,:StdOut
		
		POP 0,0

		PREFIX :

/\--------/\-------------DIESEN CODE NICHT VER�NDERN----------/\-----------/\

# Von Wolf und Fuchs
#                              __
#                            .d$$b
#                          .' TO$;\
#                         /  : TP._;
#                        / _.;  :Tb|
#                       /   /   ;j$j
#                   _.-"       d$$$$
#                 .' ..       d$$$$;
#                /  /P'      d$$$$P. |\
#               /   "      .d$$$P' |\^"l
#             .'           `T$P^"""""  :
#         ._.'      _.'                ;
#      `-.-".-'-' ._.       _.-"    .-"
#    `.-" _____  ._              .-"
#   -(.g$$$$$$$b.              .'
#     ""^^T$$$P^)            .(:
#       _/  -"  /.'         /:/;
#    ._.'-'`-'  ")/         /;/;
# `-.-"..--""   " /         /  ;
#.-" ..--""        -'          :
#..--""--.-"         (\      .-(\
#  ..--""              `-\(\/;`
#    _.                      :
#                            ;`-
#                           :\
#                           ;  
#
#
#                                                                   ,-,
#                                                             _.-=;~ /_
#                                                          _-~   '     ;.
#                                                      _.-~     '   .-~-~`-._
#                                                _.--~~:.             --.____$$
#                              ____.........--~~~. .' .  .        _..-------~~
#                     _..--~~~~               .' .'             ,'
#                 _.-~                        .       .     ` ,'
#               .'                                    :.    ./
#             .:     ,/          `                   ::.   ,'
#           .:'     ,(            ;.                ::. ,-'
#          .'     ./'.`.     . . /:::._______.... _/:.o/
#         /     ./'. . .)  . _.,'               `$$;?$$|
#       ,'  . .,/'._,-~ /_.o$P'                  $$P ?$b
#    _,'' . .,/',-~    d$$$P'                    $$'  $$|
# _.'~  . .,:oP'        ?$$b              _..--- $$.--'$b.--..__
#:     ...' $$o __,------.$$o ...__..._.=~- .    `~~   `~~      ~-.
#`.;;;:='    ~~            ~~~                ~-    -       -   -

		