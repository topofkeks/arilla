# Arilla
Arilla - Computer Architecture project, spring 2021.

**(?)** - nije nužno za MVP.

## Softver
- 16 boja (fiksne)
- Alati
    - Olovka
    - Linija
    - **(?)** Pravougaonik
    - **(?)** Paint bucket
    - **(?)** Texture brush
    - Clear Screen

## Procesor AR3B72C
- 16b memorijska reč
- 16b podaci **(i adrese?)**
- Dvoadresni format instrukcija
- Load/store arhitektura
- ~32 programski dostupna registra
- Instruction pipelining
    - Samo dve paralelne faze
        - FETCH
        - ADDR, EXEC i INTR se izvršavaju serijski
- Instrukcije na 1 ili 2 memorijske reči
    - Bezadresne (1W): `000000<OPCODE(10)>`
    - Relativnog skoka (1W): `<OPCODE(6)><OFFSET(10)>`
    - Adresne (1W): `<OPCODE(6)><OP1/DEST REG(5)><OP2 REG(5)>`
    - **(?)** Adresne sa neposrednim adresiranjem (1W): `<OPCODE(6)><OP1/DEST REG(5)><IMMED(5)>`
    - Apsolutnog skoka (2W): `000000<OPCODE(10)> <DEST(16)>`
    - LOAD/STORE (2W): `<OPCODE(6)><SRC/DEST REG(5)><ADDR(5)><ADDR(16)>`
    - **(?)** Adresne sa neposrednim adresiranjem (2W): `<OPCODE(6)><OP1/DEST REG(5)>10000 <IMMED(16)>`
- Potencijalna adresiranja
    - immed
    - memdir
    - memind
    - regdir
    - regind
    - regindpom
    - **(?)** postinc
    - **(?)** nešto fensi za adresiranje video memorije
- Stek
    - ?
- Prekidi 
    - **(?)** Maskirajući 3 ili 7
        - PSW I bit
        - PSW L biti (prihvataju samo veće)
        - IMR
        - Mogu poslati podatke **(ili broj ulaza ili adresu prekidne rutine?)** preko magistrale pri prihvatanju prekida
    - **(?)** Nemaskirajući
        - Uvek ulaz 0 u IVT
        - Watchdog magistrala
        - **(?)** Mogu poslati podatke, broj ulaza ili adresu prekidne rutine preko magistrale pri prihvatanju prekida
    - FAULT
    - **(?)** INT
    - TRAP

## Memorija
- 64MB SDRAM
- [IS42/45S16320D čip](https://www.issi.com/WW/pdf/42-45R-S_86400D-16320D-32160D.pdf)
- Adresibilna jedinica 16b
- 308 M10K blokova
    - Jedan blok 512 reči (za adresibilnu jedinicu od 16b)
    - Ukupno 154K reči
- Orgranizacija memorije
    - Program ide u internu memoriju FPGA
    - Gde idu?
        - Podaci
        - Stek
        - Video memorija
    - Adresiranje?

## Magistrale
### Memorijska magistrala
- CPU, RAM (kontroler), VRAM (GPU) i DMA
- ?

### Periferijska magistrala [PCIw](https://lazar2222.github.io/ETF/PCIw.pdf)
- CPU, PS/2 miš, GPU, DMA **i Watchdog?**
- Za slanje malih podataka i instrukcija
- Hibridna (sinhrono/asinhrona) magistrala sa atomskim ciklusima i bez arbitracije (CPU je uvek master)
- Dokumentacija SOON™
- Širina 16b?
- ?

## Grafička kartica
- VGA output
    - 640x480@60Hz (25Mhz pixel clock)
- Paleta sa 16 boja
    - **(?)** Korisnički podesivih 14 boja + crna i bela
- 7:1 odnos pristupa memoriji
- Line bafer?
- Frame bafer, ili dva?
- 1 sprite renderer za kursor
- **(??)** 1 texture renderer
- **(?)** 1 **(ili više?)** sprite/texture bafera
- **(?)** Sprite/texture (veličina, pallete ili true color?)
- Line drawer?
- Hardversko ubrzanje adresiranja frame bafera

## Kontroler miša
- PS/2 miš
- **(?)** Skrolovanje povećava veličinu četkice

## Kontroler memorije
- Služi da apstrakuje komplikacije pri pristupu SDRAM-u
- ?

## DMA
- Kako nemamo odvojen memorijski i IO prostor (PCIw nije baš IO prostor) sve se svodi na MEM-MEM operacije
- Parametri:
    - DEST
    - SRC/VAL
    - CNT
    - REPEAT
## Alati
### Mikrokod
- Signali
- Bezuslovni skokovi
- Uslovni skokovi na labelu
    - posebna labela `this`
- Višeuslovni skokovi na labele
    - automatsko generisanje adrese skoka
- Komentari
### Asembler
- **(?)** Instruction definition fajl?
- Labele
- Simboli
- Segmenti za kod i podatke
### **(?)** C -> Asembler
- C se prevodi u najprostiji asembler koji omogućava (verovatno RISC-V)
- Asembler -> Asembler prevođenje
- Verovatno Architecture definition fajl (možda isti kao i za `asm.py`)

## Hardver
- [DE0-CV](http://rti.etf.bg.ac.rs/rti/oo1pot/labvezbe/DE0_CV_User_Manual_112.pdf) razvojna ploča
    - [Cyclone V 5CEBA4F23C7N](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/cyclone-v/cv_51001.pdf) FPGA
    - 50MHz clock
    - 64MB SDRAM (16b adresibilna jedinica)
    - PS/2 interfejs
    - VGA output 4bit per channel DAC
    - 10 LED
    - 10 prekidača
    - 4 tastera
    - 6 sedmosegmentnih displeja
    - 2x20 GPIO
    - SD Card
    - Reset taster
- Cyclone V 5CEBA4F23C7N FPGA
    - 46K LE (3x više nego Cyclone III)
    - 308 M10K blokova
    - 485 MLAB blokova
    - 66 DSP blokova

## Pitanja
### Lazar
- Kako se pravi pulldown u Quartus?
- Watchdog i prepoznavanje HiZ
- Dobra dokumentacija za SDRAM?
- Kako je on zamislio organizaciju memorije (šta je gde)?
- Kako najbolje da adresiramo memoriju?
- Da li će RAM biti dovojno brz?
- Koja je njegova ideja za graficku karticu i da se nađemo na pola
- PCIw u opstim crtama i da li je to okej organizacija
- Saveti za baferovanje u grafičkoj

### Luka
- Da li imaju neke savete oko redosleda rada
- Da li je neophodno da procesor komanduje grafičkoj da iscrtava tačku, kvadrat, pravougaonik, trougao itd. ili je zbog manjeg zagušenja magistrale efikasnije da procesor direktno menja platno u memoriji
- Kada ćemo moći da krenemo da radimo sa pločicom, tj. kada će biti dostupne u RC i koje su sale u paviljonu dostupne za to pre nego što bude dostupna u RC

### Aleksa
### Ivan
