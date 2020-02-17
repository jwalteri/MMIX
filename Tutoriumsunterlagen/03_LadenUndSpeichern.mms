# Tutorium IT-Systeme
# Autor: Johannes Walter
# E-Mail: jwalter@hm.edu
# Datum: 01.01.2020
# Inhalt: Laden und Speichern

# Problem beim Ausführen: Fehler mit Buffersize?
# Loesung: Optionen -> Assemble -> Buffer Size auf 500+ stellen

		LOC 	Data_Segment
		GREG	@

# Wir definieren verschiedene Werte im Speicher

A		OCTA	#00820C29F92AE255
B		TETRA	#00000000F92A34B9
C		BYTE	10
D		OCTA	#00820C2900000000
E		WYDE	#228
F		BYTE	#30

Q		WYDE	0

array	BYTE	#AA
		BYTE	#BB
		BYTE	#CC
		BYTE	#DD

# In diesem Beispiel wird jeder Wert geladen und ein Ergebnis berechnet.
# Ein geladener Wert wird mit 0 ueberschrieben.

		LOC		#100

adr		IS		$0
tmp		IS		$1
val		IS		$2
null	IS		$3

# Gleichzeitig koennen wir die DataSegment-View oeffnen und uns das Alignment 
# des Speichers anschauen.

Main	SWYM

		SET null,0

		# Hier werden verschiedene Werte geladen und gespeichert.
		# Grundsaetzlich gilt:
		# LDA = Load Address: Laedt die SprAdr in ein Register
		# LD. value,address,offset
		#	B: Laedt ein Byte von SprAdr (address+offset)
		#	W: Laedt zwei Byte angefangen bei SprAdr (address+offset)
		#	T: Laedt vier ...
		#	O: Laedt acht ...
		#
		# ST. value,address,offset
		#	B: Speichert ein Byte an SprAdr (address+offset)
		# 	...
		# Achtung: Auch hier: Speicher wird immer aligned!
		#
		#
		# Tipp 61: Wenn ihr einen Wert ladet oder speichert und
		# ihr seht beim Debuggen, dass Nullen mit Fs aufgefuellt wurden,
		# probiert LD.U oder ST.U


		LDA adr,A
		LDO	val,adr,0
		STO null,adr,0
				
		LDA adr,D
		LDO tmp,adr,0
		STO null,adr,0

		SUB val,val,tmp

		LDA adr,B
		LDTU tmp,adr,0
		STT null,adr,0

		SUB val,val,tmp

		LDA adr,E
		LDW tmp,adr,0
		STW null,adr,0
		
		ADD val,val,tmp

		LDA adr,F
		LDB tmp,adr,0
		STB null,adr,0
		
		ADD val,val,tmp
		
		LDA adr,C
		LDB tmp,adr,0
		STB null,adr,0
		
		ADD val,val,tmp

		LDA adr,Q
		STW val,adr,0


		SET $0,0
		SET $1,0
		SET $2,0
		SET $3,0
		# Wie funktioniert das Offset?
		# Wir geben LD und ST Befehlen immer eine Adresse mit.
		# Das Offset ist eine positive Zahl, welche auf die Adresse addiert wird.
		# Vorteil: Wir ueberschreiben nicht unsere Startadresse, koennen aber
		# jede andere Adresse durch das Offset erreichen.
		# In Arrays haengt das Offset vom verwendeten "Datentypen" ab.
		# Byte=1,Wyde=2,Tetra=4,Octa=8
		# Bsp.:

		# Wir laden unsere Startadresse des Arrays 
		LDA adr,array

		# Durch Angabe eines Offsets koennen wir jedes Element dieses Arrays erreichen.
		# Zum Verstaendnis: Durch die Startadresse des Speichers 2000...0000 koennen wir auch
		# jede andere Adresse erreichen. Das Offset muss nur korrekt gewaehlt werden.

		# Wir greifen auf das erste Element zu:
		# Offset 0
		LDBU val,adr,0

		# Wir erhoehen das Offset um 1 (da Byte) um auf das zweite Element zuzugreifen:
		LDBU val,adr,1

		LDBU val,adr,2
		
		LDBU val,adr,3

		# In Schleifen kann das Offset ueber die Schleifenvariable i berechnet werden.
		# Bsp.: Bei einem Octa-Array koennen wir berechenen: offset = i * 8

		TRAP 0,Halt,0