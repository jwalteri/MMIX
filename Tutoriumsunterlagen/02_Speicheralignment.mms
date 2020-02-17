# Tutorium IT-Systeme
# Autor: Johannes Walter
# E-Mail: jwalter@hm.edu
# Datum: 01.01.2020
# Inhalt: Speicheralignment

# Problem beim Ausführen: Fehler irgendwas mit Buffersize?
# Loesung: Optionen -> Assemble -> Buffer Size auf 500+ stellen

		LOC 	Data_Segment
		GREG	@

# Wir haben bereits gelernt, dass der Speicher aus einer Reihe von Bytes besteht.
# Wir kennen folgende "Datentypen": Byte, Wyde, Tetra, Octa.
# Diese koennen wir aber nicht einfach aneinander im Speicher ablegen.
# Warum ist trivial. Aus didaktischen Gruenden ueberspringe ich die Erklärung.
# 
# Wir stellen uns den Speicher noch zusätzlich unterteilt in 8er Bloecke vor.
# In einem 8er Block koennen 8 Bytes, 4 Wydes, 2 Tetras (oder 1 Octa) hintereinander gespeichert werden.
# Diese muessen aber immer nach ihrer "Laenge" eingeordnet werden
# Folgt auf einen Byte ein Wyde, wird ein Byte dazwischen leer gelassen.
# Folgt auf einen Byte ein Tetra. werden 3 Bytes dazwischen leer gelassen.
# Und so weiter.
# Hier eine aeusserst raffinierte Darstellung:
# 
# Allgemeine Darstellung:
#  __________________________________________________________________________
# |      |      |      |      |      |      |      |      |||||      |      
# | BYTE | BYTE | BYTE | BYTE | BYTE | BYTE | BYTE | BYTE ||||| BYTE |...
# |______|______|______|______|______|______|______|______|||||______|_______
#
# Speichern eines Bytes gefolgt von einem WYDE
#  __________________________________________________________________________
# |      |      |      |      |      |      |      |      |||||      |      
# | BYTE | LEER | WYDE | WYDE | LEER | LEER | LEER | LEER ||||| LEER |...
# |______|______|______|______|______|______|______|______|||||______|_______
#
# Speichern eines Bytes gefolgt von einem TETRA
#  __________________________________________________________________________
# |      |      |      |      |      |      |      |      |||||      |      
# | BYTE | LEER | LEER | LEER | TETRA| TETRA| TETRA| TETRA||||| LEER |...
# |______|______|______|______|______|______|______|______|||||______|_______
#
# Speichern eines Bytes gefolgt von einem Octa
#  ______________________________________________________________________________________________________________________________________
# |      |      |      |      |      |      |      |      |||||      |      |      |      |      |      |      |      |||||      |           
# | BYTE | LEER | LEER | LEER | LEER | LEER | LEER | LEER ||||| Octa | Octa | Octa | Octa | Octa | Octa | Octa | Octa ||||| LEER |...
# |______|______|______|______|______|______|______|______|||||______|______|______|______|______|______|______|______|||||______|_______
#


# Bsp:

byte	BYTE	#AA
wyde	WYDE	#BBBB
tetra	TETRA	#CCCCCCCC
octa	OCTA	#DDDDDDDDDDDDDDDD



		LOC		#100

Main	SWYM

		# Zum Debuggen oeffnen wir wieder die DataSegment-View
		# Wir stoppen bei Main.
		# Was sehen wir?
		# byte: Unser Byte wurde an der ersten freien Spradr gespeichert.
		# wyde: Unser Wyde wurde aligned an der dritten Spradr gespeichert.
		# tetra: Unser Tetra musste nicht aligned werden, da der Speicher bereits korrekt aligned ist.
		# Unser Byte belegt das erste Byte, darauf ein leeres Byte, darauf zwei Bytes = 4 Bytes
		# Danach kann also direkt unser Tetra gespeichert werden.
		# octa: Unser erster imaginaerer 8er Block ist voll. Unser Octa kommt in den naechsten freien 8er Block.
		# Da dieser komplett leer ist, muss nichts aligned werden.

		# Auf was muessen wir also beim Alignment achten?
		# Wenn wir Werte abspeichern, liegen diese nicht unbedingt immer hintereinander im Speicher.
		# Dies ist besonders beim "iterieren des Speichers mit Hilfe eines Offsets" zu beachten.
		# Dazu in einem anderen Kapitel mehr.
		TRAP 0,Halt,0