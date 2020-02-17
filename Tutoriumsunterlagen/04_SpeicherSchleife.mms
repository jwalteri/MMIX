# Tutorium IT-Systeme
# Autor: Johannes Walter
# E-Mail: jwalter@hm.edu
# Datum: 01.01.2020
# Inhalt: Durchlaufen des Speichers mit einer Schleife

# Problem beim Ausführen: Fehler irgendwas mit Buffersize?
# Loesung: Optionen -> Assemble -> Buffer Size auf 500+ stellen

		LOC		Data_Segment
		GREG	@

# Wir definieren ein """"Array"""" (es ist kein Array...)

a1	BYTE 1,2,3,4,5,6,7,8,9

a2 	WYDE #A
	WYDE #B
	WYDE #C

a3	TETRA 1,2,3,4,5,6,7,8,9
	TETRA 9,8,7,6,5,4,3,2,1

		LOC		#100
# In diesem Programm greifen wir mit einer Schleife und Offset auf den Speicher zu.
adr		IS		$0
i		IS		$1
val		IS		$2
tmp		IS		$3
offset	IS		$4

Main 	SWYM
		SET i,0
		LDA adr,a1

# Erklaerung:
# Es gibt immer eine Schleife.
# In dieser Schleife greifen wir nacheinander auf jeden einzelnen Wert zu.
# Da wir nur eine SprAdr, aX, haben, müssen wir auf diese Adresse ein Offset addieren.
# Dieses Offset haengt von der Schleifenvariable und dem "Datentyp" ab
# Offset = i * (Byte=1,WYDE=2,TETRA=4,OCTA=8)
# Dieses Offset kann man bei ST. und LD. Befehlen angeben

# for (int i = 0; i < 9; i++)
loop	CMP tmp,i,9
		BZ tmp,end

			# Berechnung des offsets
			MUL offset,i,1
			# Wir laden ein Byte an der SprAdr "adr" mit dem Offset "offset"
			LDB val,adr,offset

		ADD i,i,1
		JMP loop

end		SWYM

###################################################

		SET i,0
		LDA adr,a2

# for (int i = 0; i < 3; i++)
loop2	CMP tmp,i,3
		BZ tmp,end2

			MUL offset,i,2
			LDW val,adr,offset

		ADD i,i,1
		JMP loop2

end2	SWYM

###################################################

		SET i,0
		LDA adr,a3

# for (int i = 0; i < 18; i++)
loop3	CMP tmp,i,18
		BZ tmp,end3

			MUL offset,i,4
			LDT val,adr,offset

		ADD i,i,1
		JMP loop3

end3	SWYM		

		TRAP 0,Halt,0