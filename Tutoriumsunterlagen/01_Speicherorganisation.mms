# Tutorium IT-Systeme
# Autor: Johannes Walter
# E-Mail: jwalter@hm.edu
# Datum: 01.01.2020
# Inhalt: Speicherorganisation

# Problem beim Ausführen: Fehler irgendwas mit Buffersize?
# Loesung: Optionen -> Assemble -> Buffer Size auf 500+ stellen

		# Wird IMMER benoetigt, wenn wir Daten im Datensegment speichern wollen
		LOC	Data_Segment
		# Das kommt IMMER nach LOC Data_Segment
		GREG @

# Speicherorganisation:
# Der Speicher in MMIX besteht aus einer langen Reihe von Bytes.
# Jedes dieser Bytes hat eine eindeutige Adresse.
# D.h., wir können zu jedem Zeitpunkt jede Adresse laden oder speichern.
# Wiederholung: Ein Byte = #FF, also zwei Zeichen!
# Ein Byte erstreckt sich also nur über eine Adresse, z.B. 2000...0000.
# Ein Wyde besteht aus zwei Byte => erstes Byte (2000...0000) zweites Byte (2000...0001)
# Ein Tetra besteht aus vier Byte => 2000...0000,...0001,...0002,...0003
# Ein Octa besteht aus acht Byte => ...
# Was bedeutet das jetzt konkret?
# Der Speicher weiss nicht wie er organisiert ist, nur der Programmierer.
# D.h., wir können hintereinanderliegende Bytes laden und speichern.
# Bsp.: Wir haben zwei Bytes hintereinander im Speicher. Diese müssen wir nicht einzeln laden, sondern koennen
# diese gleichzeitig als Wyde (Wyde = zwei im Speicher hintereinanderliegende Bytes) laden.
# Gleiches Prinzip für 8xBytes=Octa, 4xBytes=Tetra, 2xTetras=Octa, etc.

# Die erste Speicheradresse ist 2000...0000, d.h., das erste zu speichernde Element wird dort abgelegt.
# Bsp.: 

first	BYTE	42

# first ist nun der "Name" für die Speicheradresse 2000...0000. Hinter diese SprAdr verbirgt sich der Wert 42.
# Damit haben wir den ersten Byte in der Reihe aller Bytes belegt.
# Weitere Daten können an der nächsten freien SprAdr abgelegt werden.
# Hier ist die nächste freie SprAdr: 2000...0000 + 1, da wir auf 2000...0000 schon einen Byte gespeichert haben.

# Bsp.:

second BYTE		69

		# Wird IMMER benötigt. Danach kommt unser Hauptprogramm, unsere lokalen Variablen etc.
		LOC #100

firstAdr	IS		$0
firstVal	IS		$1

secondAdr 	IS		$2
secondVal	IS		$3

wydeAdr		IS		$4
wydeVal		IS		$5

# Hier bietet es sich an eine weitere View, DataSegment, beim Debuggen zu oeffnen.
# Diese und weitere Views koennt ihr unter 
# View -> Memory -> Data Segment 
# oeffnen. 
# Erklaerung zum Data Segment View:
# Oben links koennt ihr wie immer die Ansicht aendern: OCTA, TETRA, WYDE, BYTE
# Das kann nützlich sein, wenn ihr z.B. Bytes gespeichert habt und diese deutlicher
# voneinander trennen wollt.
# Aenderung der Wertedarstellung: Hex, Int,... normlerweise braucht ihr nur Hex
# Go to: Hiermit koennt ihr an die angegebene Adresse springen.
# Links koennt ihr die Adresse des ersten Bytes in der dargestellten Reihe sehen.
# Springt ihr nun an eine bestimmte Adresse mit "Go to:", dann wird die Ansicht
# so verschoben, dass das erste dargestellte Byte, das an der von euch gesuchten 
# Adresse ist.
# Bsp.: Debuggt dieses Programm. Stoppt bei Main. Oeffnet die DataSegment View.
# Wir sehen die erste Adresse 2000...0000. Das erste Byte hat den Wert "2A"
# Gotoen wir jetzt zur Adresse 2000...0001 veraendert sich die Ansicht und wir
# sehen "45" als erstes Byte.
# Reset: Go to 0x2000000000000000, wie kann man sich das merken? 0x2000 + 3x 0000
# oder ihr schaut einfach eine gerade angezeigte Adresse an und setzt wieder alles auf 0 (ausser 2)


Main	SWYM

		# Wir laden die Speicheradresse hinter "first" in firstAdr
		LDA firstAdr,first
		# Wir laden den Wert an der SprAdr firstAdr in firstVal
		LDB firstVal,firstAdr,0

		# Laden der SprAdr
		LDA secondAdr,second
		# Laden der Value
		LDB secondVal,secondAdr,0

		# Laden beider Werte gleichzeitig als Wyde
		# Nur moeglich, da diese hintereinander im Speicher liegen
		
		# Wir laden die Adresse, an der unser Wyde startet
		LDA wydeAdr,first
		# Wir laden ein Wyde, welches an der Adresse von first beginnt.
		# Ein Wyde besteht aus 2 Byte. Wir laden also die Werte von
		# first und second gleichzeitig.
		LDW wydeVal,wydeAdr,0

		TRAP 0,Halt,0
		

