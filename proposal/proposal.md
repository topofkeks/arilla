# ARILLA - projekat iz Arhitketure računara, 2021.

## Uvodna reč

**Arilla** je 16-bitni računarski sistem, sastavljen od procesora sa reči dužine 16 bita, 64 MB SDRAM radne memorije povezane memorijskom magistralom, kao i magistrale za periferije. Periferije namenjene za računar su VGA grafička kartica i PS/2 miš. Takođe sadrži i DMA kontroler. Računar je namenjen da izvršava jednostavan **Paint** program koji se nalazi u ROM memoriji. U ovom dokumentu nalazi se detaljna, ali ne potpuna i konačna specifikacija implementacije, počevši od samog procesora preko memorije do periferija, i na kraju samog softvera.

Redovi i rečenice označeni sa **(?)** predstavljaju nepotpune, nenužne ili manje bitne mogućnosti i implementacione detalje.

## Procesor *AR3B72C*

### Arhitektura

### Skup instrukcija

### Prekidi

## Memorija

## Magistrale

### Memorijska magistrala

### Periferijska magistrala *PCIw*

## Grafička kartica

## Periferije i kontroleri

### Miš

### DMA kontroler

## Softver

### Pregled funkcionalnosti programa

Program *Paint* služi za crtanje skica na računaru pomoću miša, nalik na sadašnje korisničke programe te svrhe. Korisnik kursorom miša bira alate i crta po platnu. Program se sastoji od jednog dijaloga koji sadrži platno (gore) i traku sa alatima i bojama (dole). Program pamti stanje platna, kao i trenutno izabran alat, primarnu i sekundarnu izabranu boju.

### Platno

Platno je rezolucije 640x400 i podržava 16 boja u jednom video-okviru (boje se mogu mapirati iz šireg skupa pomoću instrukcija grafičke kartice **(?)**, ali u jednom video-okviru u jednom trenutku je moguće iscrtati samo 16 boja). Ovaj prostor boja je podržan u svakom pikselu, tj. ne postoji nikakva kompresija prostora boja ili same rezolucije platna. Platno se čuva u radnoj memoriji računara. 

### Skup alata

* Olovka
* Linija
* Pravougaonik
* **(?)** Teksturna olovka
* Kanta za boju (*Paint Bucket*)
* Brisanje platna

### Interagovanje korisnika sa programom

Celokupna interakcija se sastoji od miša. Levim klikom se na platno upotrebljava trenutno izabrani alat. U predelu trake sa alatima, levi klik u prostoru "tastera" određenog alata ga postavlja za trenutno izabrani, osim alata za brisanje platna. U predelu trake sa bojama, levi klik na određenu boju je postavlja za trenutno izabranu primarnu boju, a desni klik postavlja kao sekundarnu.

Kod alata *Olovka*, skrol miša menja veličinu same olovke u jedinicama zahvaćenih piksela. 

Interakcija kursora sa programom se realizuje pomoću prekidne rutine za miš, koji proverava poziciju kursora i u odnosu toga odlučuje da li je u predelu platna ili trake alata. U slučaju trake alata, postavljaju se promene u stanje programa, a u slučaju platna se proverava da li je miš kliknut, tako da se izvrši funkcija alata, pa onda da li je miš pomeren, da bi se izvršilo ažuriranje pozicije kursora.