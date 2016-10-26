== Francesco NLP data ==
x Normalisierung bitte dort unternehmen


== Ideen ==
*  wie bei Artikeln das gleiche schon bei ganzen Zeitschriften anzeigen, häufigste Orte usw -> dazu müssen Terms schon dort normalisiert werden

== todo ==
* sign-in / sign-out button geht nicht

navbar
# home button - aufs richtige home bitte
# About- weg
# userhome - weg -> is im user menu drin 
- search - testen
# language - testen
# login/register - muss funktionieren
# logout - funktioniert nicht
# current / archives / browse etc. besser
# ist browse by issue und arhcives dasselbe? -> eines weg

-
# icons schöner
# last abstand
# menü ordentlich (hover!) 

insg. mobile friendlier
# menu klappbar 
+ bootstrap.js einbinden

pages
# user home
- korrekte anzeige bei allen listen PDF-Button etc.
# archive auf Startseite von Journal 
# issue url stimmt nicht
# überschrift lokalisieren

sidebar
+ wegmachen in no-journal ansicht 

sonst
# url problem

cover
# "Journal Logo" richtig anzeigen (im Header der journal Startseite)
# "Journal thumbnail" richtig anzeigen (in der Journal übersicht)
# "Homepage image" -> wird unter dem Text angezeigt, ist OK so 

issue ansicht
# pdf button weg, aber bei manchen entsteht kein link! (in browse by title)

search
# findet keine Ergebnisse
# search von der startseite geht gar nicht
# search filter nicht clickbar, weil handler.js l. 37 abbricht mit einem error

bugs
- suche funktioniert von unterseiten nicht
- layout von suchergebnissen stimmt nicht ganz (padding-left)



more
* annotations-daten handling
	* annotationsdaten auch php seitig verfügbar halten (cache) 
	* und in meta-daten von Seite einfließen lassen (wegen google)
	* und der suche bekannt machen irgendwie
	* nlp server ist nicht von außen zugreifbar!!

	a) Servereitig -> holt adaten -> baut boxen -> die greifen auf den reader zu
		(+) weniger API-Calls, Cache evtl. nutzbar?
		(-) kommunikation zwischen in und außerhalb iframe
		(-) DBV nicht extern nutzbar
		
	b) Sidebar Teil des Iframes
		(-)	Größe bestimmen?
		(-)	wie adaten Google etc. bekannt machen?
			a) den API Call beim Page aufruf machen und die Adaten auch im Quelltext verankern, und im DBR von dort lesen
			b) die wichtigsten Adaten einmalig von dort ins OJS überführen 1) und für den Reader unabhängig davon per API-Call holen (über eine digeste funktion)
				(+)	nicht alle Daten müssen in der Seite gespeichert werden, es sind ja sehr viele, und später kann man vllt. Seitenwase API Calls machen oder so
				(+) man könnte die Boxen erst befüllen und dann per APi ersetzen lassen!
				(+) Daten fließen weiter in den Zenon
				
				1) wie? evtl. durch direkten insert in die DB...
				im plugin->load Article Page ein getMetadata 
					-> if empty then try to fetch
						-> if nothing store fetchedNothing
				im plugin 
				
	bb ist möglicher Weise das Beste

* disable cache and stuff

== importer ==
x Bekanntschaft mit zenon
xx xml perfektionieren
xxx volume und year erschienen nicht! 
++ xml an ende auch schicken
xx liste mit ids
x intro-Seite




 

/* *************************** */
Fragen:
* Licensed under Creative Commons 
* 

