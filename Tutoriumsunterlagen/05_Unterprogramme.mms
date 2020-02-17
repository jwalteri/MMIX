# Tutorium IT-Systeme
# Autor: Johannes Walter
# E-Mail: jwalter@hm.edu
# Datum: 01.01.2020
# Inhalt: Unterprogramme

# Problem beim Ausführen: Fehler irgendwas mit Buffersize?
# Loesung: Optionen -> Assemble -> Buffer Size auf 500+ stellen

# Dieses Programm berechnet: (x+y)^2
# Hauptprogramm:
# Ruft das erste Unterprogramm mit zwei Werten auf.
#
# Erstes Unterprogramm:
# Erhaelt bei Aufruf zwei Werte.
# Berechnet die Summe dieser Werte.
# Ruft mit der Summe das zweite Unterprogramm auf.
# Gibt den Rueckgabewert als eigenen Rueckgabewert zurueck.
#
# Zweites Unterprogramm:
# Erhaelt bei Aufruf einen Wert.
# Berechnet x^2 und gibt das Ergebnis als Rueckgabewert zurueck.

# Besonderheit:
# Aufruf eines Unterprogramms in einem Unterprogramm.
# Loesung: rJ-Register und damit die Ruecksprungadresse sichern.

		LOC		#100
# Bei der Verwendung von Unterprogrammen ist die korrekte Variablen"deklaration" sehr wichtig.
# Jeden Unterprogramm uebergibt man ein "PUSHJ-Register", hier immer als "param" benannt.
# Dieses PUSHJ-Register wird zu einem "Loch". Der darin gespeicherte Wert geht verloren.
# Alle Register nach dem PUSHJ-Register werden als Parameter an das Unterprogramm uebergeben und im Hauptprogramm geloescht.
# Alle Register vor dem PUSHJ-Register bleiben erhalten.
#
# Parameter:
# Das erste Register (param+1) nach dem PUSHJ-Register ist der erste Parameter. Dieses Register wird zum $0 im Unterprogramm.
# Das zweite Register (param+2) wird zu $1, etc.
# 
# Rueckgabewert:
# Im Unterprogramm ist $0 das Rueckgaberegister. D.h., dass der Wert in $0 in das aufrufende Programm zurueckgegeben wird.
# Im aufrufenden Programm wird der Rueckgabewert in das PUSHJ-Register geschrieben, also param.

# Bsp.:

# Die Register $0, $1 und $2 werden hier beim Aufrufen von Unterprogrammen nicht verwendet.
# Grund: Das PUSHJ-Register ist $3.
x		IS		$0
y		IS		$1
z		IS		$2

# Das PUSHJ-Register. Der darin enthaltene Wert wird beim Unterprogrammaufruf geloescht.
# Der Rueckgabewert des Unterprogramms wird in diesem Register gespeichert.
param	IS		$3
# Alle Register nach dem PUSHJ-Register ($4, $5,...) werden als Parameter an das Unterprogramm uebergeben.
# Nach der Abarbeitung des Unterprogramms und der Rueckkehr in das aufrufende Programm sind diese Register alle gelöscht.
# D.h., Werte, welche noch nach der Abarbeitung des Unterprogramms benoetigt werden, muessen VOR dem PUSH-Register gespeichert werden.  <-------


# Dieses Programm soll mit Einzelschritten gedebuggt werden.
# Mit "Step Instruction" koennen wir das Unterprogramm, welches von PUSHJ aufgerufen wird, betreten.
# Unter "View" -> "Register" -> "Special" koennen wir die Spezialregister wie rJ, rR, etc. anzeigen lassen.
Main	SWYM

		
		# Wir initalisieren die Variablen x,y und z.
		# Wir erwarten, dass diese Variablen nach dem Unterprogrammaufruf immer noch diese Werte halten.
		SET x,3
		SET y,3
		SET z,#FEFE


		# Wir setzen als ersten Parameter in das erste auf das PUSHJ-Register folgende Register (also $4) den Wert von x.
		SET param+1,x
		# Der zweite Parameter ($5) wird auf y gesetzt.
		SET param+2,y

		# Wir rufen das erste Unterprogramm auf.
		# Wir erwarten, dass im Unterprogramm $0 den Wert von x und $1 den Wert von y haelt.
		#
		# Nach der Rueckkehr ins Hauptprogramm erwarten wir, dass im PUSHJ-Register "param" der Rueckgabewert steht.
		PUSHJ param,ErstesUnterprogramm:start

		TRAP 0,Halt,0

########################################################################
########################################################################
########################################################################
########################################################################

		# PREFIX oeffnet einen neuen Namensraum.
		# Zugriffe auf Elemente ausserhalb dieses PREFIXes verlangen ein ":".
		PREFIX :ErstesUnterprogramm:

# Wir erwarten, dass x auf den Wert unseres ersten Parameters gesetzt wird
x		IS		$0
# Wir erwarten, dass y auf den Wert unseres zweiten Parameters gesetzt wird
y		IS		$1
# In diesem Register speichern wir die Ruecksprungadresse (rJ) ins Hauptprogramm.
rJSafe	IS		$2
# Unser PUSHJ-Register fuer das zweite Unterprogramm
param	IS		$3

start	SWYM

		# Mit GET holen wir den Wert aus dem Spezialregister rJ. 
		# rJ ist die Ruecksprungadresse ins Hauptprogramm.
		# Achtung: Wir benoetigen ":", da wir in einem Unterprogramm sind.
		GET rJSafe,:rJ

		# Wir setzen den ersten und einzigen Parameter fuer das zweite Unterprogramm.
		ADD param+1,x,y
		# Wir rufen das zweite Unterprogramm auf.
		# Wir erwarten bei Rueckkehr ins erste Unterprogramm den Rueckgabewert in "param".
		PUSHJ param,:ZweitesUnterprogramm:start

		# Wir setzen unseren Rueckgabewert (hier: param, also $3) ins Rueckgaberegister (hier: x, da IMMER $0)
		SET x,param

		# VOR der Rueckkehr in die aufrufende Funktion MUESSEN wir rJ wieder herstellen.
		# Warum? Die urspruengliche Rueckgabeadresse wurde durch den zweiten Unterprogrammaufruf ueberschrieben.
		# Jetzt muessen wir den gesicherten Wert in das rJ-Register schreiben.
		# Falls dieser Schritt fehlt, koennen wir nicht mehr ins Hauptprogramm zuruckspringen.
		# Ergebnis ist ein Festhaengen beim POP Befehl.
		PUT :rJ,rJSafe

		# Wir kehren mit einem Rueckgabewert ins aufrufende Programm zurueck.
		# Der Rueckgabewert steht IMMER in $0.
		POP	1,0

########################################################################
########################################################################
########################################################################
########################################################################


		PREFIX :ZweitesUnterprogramm:
# In diesem Register landet der Parameter.
# Hier erwarten wir den Wert 6.
x		IS		$0

start	SWYM
		
		# Wir multiplizieren den Wert mit sich selbst.
		# Da wir uns bereits im Register $0 befinden, muessen wir den Rueckgabewert nicht
		# mehr in ein spezielles Register laden.
		MUL x,x,x

		# Wir geben den Wert in $0 als Rueckgabewert zurueck.
		POP 1,0


