# Arilla
Arilla - Computer Architecture project, spring 2021.

## Ideje
- Paint
- Klavir?
- Super Mario
- Bullet hell
- osu!

## Delovi računara
- Procesor (AR3B72C)
    - Zaduženi: ???
    - Manje više isto kao na ORT2 samo bez CISC instrukcija
    - Možemo iskoristiti naš mikrokod i šeme sa ORT2 projekta
    - Kako bismo odredili potrebne instrukcije i načine adresiranja najbolje je da prvo napišemo program koliko god možemo
        - Možemo da koristimo i dvoadresne, troadresne instrukcije
        - Neke stvari u programu mogu da ostanu opcione i one neće biti uključene u prvu verziju programa
    - GPR sadrži 16 registara, a ako nam bude bilo potrebno još možemo da proširimo
        - Dva su za apsolutnu poziciju miša
    - Pipeline
    - Load/store arhitektura, 2A, relativni skokovi osim ako ne moramo apsolutne (JMP, BRNCH)
- Program
    - Zaduženi: Luka
    - Kad se odlučimo za ideju, isplanirati delove programa
	- Debug rutina
- Grafička kartica
    - Zaduženi: Laza
    - Komunicira sa monitorom preko VGA
    - Vuče sadržaj ekrana iz memorije
    - Ekran je veličine 640x480 (trebalo bi)
    - Imamo primer ORT2 labova sa grafikom na Vukovom drajvu
	- 16 boja
	- Šaljemo instrukcije za pomeraj miša i za zamenu bafera i ako stignemo instrukciju za slanje palete
		- Posebno kodiranje instrukcija
- Kontroler miša
    - Zaduženi: ???
    - Komunicira sa tastaturom ili mišem preko PS/2
    - Imamo primer komunikacije sa tastaturom na Vukovom drajvu
- Kontroler memorije
    - Zaduženi: ???
    - Memorijska reč je 16 bita
    - Adrese su 13 bita (?)
- Magistrala
    - Zaduženi: Laza (1/2)
    - Arbitracija
    - Sinhrona/asinhrona
    - Sa čekanjem ili odvojenim instrukcijama
	- Dve magistrale, memorija (RAM, CPU, grafička, DMA) i periferije (CPU, grafička, DMA, miš)
- Alati
    - Zaduženi: Luka
    - Modifikacija [mic.py](https://github.com/KockaAdmiralac/ORT2/blob/master/mic/mic.py) sa Lazinim dodacima
    - Za asembler prvo moramo imati format instrukcija i načine adresiranja pa to primeniti na [asm.py](https://github.com/KockaAdmiralac/ORT2/blob/master/asm/asm.py)
	- Asembler treba da dozvoljava dodatne instrukcije i labele tretira kao promenljive
    - Možemo napraviti simulator našeg asemblera kako bismo bez spuštanja na FPGA testirali program
- Dostavljanje arhitekture angažovanima na predmetu
    - Zaduženi: ???
    - Ovo radimo nakon što imamo okviran program, format instrukcija i arhitekturu magistrale

## Potrebne komponente
- Brojač (imamo)
- Constant (imamo)
- Buffer (`tri`)
- Prioritetni koder (?)
- Dekoder (?)
- Multiplekser (imamo)
- Sabirač (?)
- Oduzimač (?)
- Komparator (imamo)
- Šifter (?)
- ROM (?)
- Sedmosegmentni interfejs (imamo)
- CLK_DIVIDER
- RisingEdge (?)

## Pitanja
- Kako radimo pulldown u Quartus?
- Da li nam je zaista potreban IMR?
- Da li moraju bitovi instrukcije da imaju posebno značenje ("bit 7 prvog bajta instrukcije znači da je bezadresna bla bla")?
- Da li je u redu da koristimo dupli bafer u grafičkoj i koju komponentu za to da koristimo?
- Imamo li primer komunikacije sa mišem?
- Da li možemo da koristimo i Cyclone III i Cyclone V?
- Što se na projektima iz ORT2 koristi 800x600?
- Kako radi RAM?

## Napomene
- Na kraju svega, svi moraju da znaju kako svaki deo projekta radi
