# LP MMIX WS1920
# Hobi und Wallo


\/--------\/-------------DIESEN CODE NICHT VERÄNDERN----------\/-----------\/
		LOC		Data_Segment
		GREG	@

data	OCTA	#00000000000050
		OCTA	#00000000000050

adr		BYTE	" ___________ ",0
		BYTE	"|  _______  |",0
		BYTE	"| |  ___  | |",0  
		BYTE	"| | |   | | |",0
		BYTE	"| | |___| | |",0
		BYTE	"| |_______| |",0
		BYTE	"|___________|",0

arrow	BYTE	"| | |_\ | | |",0
		BYTE	"| |____\__| |",0
		BYTE	"|______/\___|",0

		LOC		#100
GPutStr	IS	#2A
GSetPos	IS	#24
R255	GREG	0

t		IS		$0

Main	SWYM
		PUSHJ	$100,:TrapGetTarget:get
		SET		$255,R255
/\--------/\-------------DIESEN CODE NICHT VERÄNDERN----------/\-----------/\
\/--------\/-------------          IHR CODE         ----------\/-----------\/



		SET 	t+1,$255
		PUSHJ	t,:PrintTarget:print



/\--------/\-------------         IHR CODE          ----------/\-----------/\
\/--------\/-------------DIESEN CODE NICHT VERÄNDERN----------\/-----------\/

		SET		t+1,30
		SET		t+2,30
		PUSHJ	t,:Aim:aim

		SET		t+1,t
		PUSHJ	t,:PrintArrow:print

		TRAP	0,Halt,0
/\--------/\-------------DIESEN CODE NICHT VERÄNDERN----------/\-----------/\




\/--------\/-------------          IHR CODE         ----------\/-----------\/



		PREFIX	:Aim:
x		IS		$0
y		IS		$1
aim		SWYM

		MUL		x,x,7
		MUL		y,y,7

		SL		x,x,32
		OR		x,x,y

		POP		1,0
		PREFIX	:




 /\--------/\-------------         IHR CODE         ----------/\-----------/\





 \/--------\/-------------DIESEN CODE NICHT VERÄNDERN----------\/-----------\/

		PREFIX	:PrintArrow:
pos		IS		$0
adr		IS		$1
i		IS		$2 
tmp		IS		$3
y		IS		$4
print	SWYM

		SET		y,60
		SET		tmp,#00D2
		SL		tmp,tmp,32
		OR		tmp,tmp,#00D2
		CMP		tmp,pos,tmp
		BZ		tmp,go
		ADD		y,y,100

go		LDA		adr,:arrow
loop	CMP		tmp,i,3
		BZ		tmp,end
	
		SET		$255,0

		SET		$255,#0010
		SL		$255,$255,16
		ADD		y,y,20
		OR		$255,$255,y

		TRAP	0,:GSetPos,0

		MUL		tmp,i,14
		ADD		$255,adr,tmp
		TRAP	0,:GPutStr,0
			
		ADD 	i,i,1
		JMP 	loop
		
end		POP		0,0
		PREFIX	:


		PREFIX	:TrapGetTarget:
get		SWYM
		LDA 	:R255,:adr
		POP		0,0
		PREFIX	:

		PREFIX	:PrintTarget:
adr		IS		$0
i		IS		$1
tmp		IS		$2

print	SWYM
		
loop	CMP		tmp,i,7
		BZ		tmp,end
		
		SET		tmp,#0010
		SL		tmp,tmp,16
		MUL		tmp+1,i,20
		OR		$255,tmp,tmp+1
		TRAP	0,:GSetPos,0

		MUL		tmp,i,14
		ADD		$255,adr,tmp
		TRAP	0,:GPutStr,0

		ADD 	i,i,1

		JMP 	loop

end		SWYM
		POP 0,0

		PREFIX	:


/\--------/\-------------DIESEN CODE NICHT VERÄNDERN----------/\-----------/\

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

		