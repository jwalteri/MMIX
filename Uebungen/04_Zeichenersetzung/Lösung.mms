
\/--------\/-------------DIESEN CODE NICHT VERÄNDERN----------\/-----------\/	
		LOC		Data_Segment
		GREG @

string	BYTE	"________________",0
data	OCTA	#0C1A170D3F180A0B
		OCTA 	#33191A0D0B16183E
		LOC		#100

FPuts		IS	#07
GSetPos 	IS	#24
/\--------/\-------------DIESEN CODE NICHT VERÄNDERN----------/\-----------/\


		PREFIX	:Go:
adr		IS		$0
i		IS		$1
offset	IS		$2
val		IS		$3
rJSafe	IS		$4
tmp		IS		$5

go		SWYM
		GET rJSafe,:rJ

loop	CMP tmp,i,16
		BZ tmp,end

		LDA adr,:data
		LDB tmp+2,adr,i
		SET tmp+1,i
		PUSHJ tmp,:GetValue:get

		LDA adr,:string
		STB tmp,adr,i

		ADD i,i,1

		JMP loop
			
end		SWYM
		PUT :rJ,rJSafe

		POP 0,0

		PREFIX	:

\/--------\/-------------DIESEN CODE NICHT VERÄNDERN----------\/-----------\/

Main	SWYM
tmp 	IS	$0
		SET $1,0

		PUSHJ $0,Go:go

		SET tmp,#0010
		ORML tmp,#0010
		SET $255,tmp
		TRAP 0,GSetPos,0

		LDA $255,string

		TRAP 0,FPuts,:StdOut

		TRAP 0,Halt,0

	PREFIX :GetValue:
id		IS	$0
subVal	IS	$1
adr		IS	$2
val		IS	$3

get SWYM

	LDA adr,:string
	LDB val,adr,id

	SUB id,val,subVal

	POP 1,0

	PREFIX :
/\--------/\-------------DIESEN CODE NICHT VERÄNDERN----------/\-----------/\
