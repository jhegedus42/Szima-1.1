# Független E8–Steane-levezetés

Ez a könyvtár önálló. Nem módosítja és nem importálja a projekt meglévő
algebrai vagy ügynöki rétegeit.

## Mit bizonyít a fordító?

Az `E8SteaneLevezetes.idr` véges felsorolással ellenőrzi:

1. A négy megadott generátor 16 különböző nyolcbites kódszót ad.
2. A kód lineáris, minimumtávolsága 4, kétszeresen páros és önduális.
3. Ez a bináris `[8,4,4]` kód a Construction A bemenete az E8-rácshoz.
4. A súlyeloszlás `1 + 14·y⁴ + y⁸`; ezért a Construction A pontosan
   `16 + 14·16 = 240` minimális vektort ad.
5. Egy koordináta elhagyásával `[7,4,3]` Hamming-kód keletkezik.
6. A kiszámított duális kód `[7,3,4]`, és része a Hamming-kódnak.
7. A Calderbank–Shor–Steane-konstrukció paraméterei `[[7,1,3]]`.

A fordító a teljes nyolcbites tér 256 és a teljes hétbites tér 128 elemét
is felsorolja a duális kódok kiszámításakor. Az öndualitás és a duális
tartalmazás ezért nem beírt darabszám, hanem véges ellenőrzés eredménye.

## A paritásbuborék pontos tartalma

A `ParitasBuborek.idr` az előző láncban rejlő további szerkezetet
ellenőrzi.

Legyen `C8` a kiterjesztett Hamming-kód, `C7` az első koordináta
elhagyásával kapott Hamming-kód. A törölt koordináta minden kódszónál
egyenlő a megmaradt hét koordináta paritásával. A `C7` páros súlyú
részkódja pontosan `C7` duálisa. Ezért a paritás konkrét hányadosleképezés:

```text
0 → C7-duális → C7 → kételemű test → 0
```

A mag nyolcelemű, a páratlan mellékosztály is nyolcelemű. A törölt bit
tehát nem egyszerűen elveszik: a kilyukasztás után a
`C7 / C7-duális` hányados egyetlen logikai jeleként jelenik meg.

A Calderbank–Shor–Steane-konstrukció két klasszikus összetevője két
ilyen mellékosztályjelet ad:

```text
(C7 × C7) / (C7-duális × C7-duális)
    ≅ kételemű test × kételemű test.
```

A modul közvetlenül felsorolja:

- a normalizátor 256 fázis nélküli Pauli-mintáját;
- a stabilizátor 64 mintáját;
- a négy, egyenként 64 elemű logikai mellékosztályt;
- a két logikai alapoperátor nemnulla szimplektikus párosítását;
- a nemtriviális logikai Pauli-operátorok hármas minimumsúlyát.

Ez a négyelemű, nemelfajuló szimplektikus hányados pontosan egy logikai
kubit fázis nélküli Pauli-tere. A `paritásbuborék` elnevezés ennek a
könyvtárnak a neve a kilyukasztással létrejövő egydimenziós klasszikus
öndualitási hiányra. Nem bevett fizikai szakkifejezés.

A globális `±1` és `±i` Pauli-fázisokat megtartó teljes csoporthányados
nem azonos a négyelemű bináris térrel. A modul a szokásos fázismentes
szimplektikus címkéket számolja; csoportnyelven a pontos állítás:

```text
Pauli-normalizátor / (stabilizátor × Pauli-középpont)
    ≅ kételemű test × kételemű test.
```

Shubham P. Jain és Victor V. Albert 2024-es általános konstrukciója
ugyanezt a műveletet használja: kétszeresen páros önduális klasszikus kód
egy koordinátájának kilyukasztásából egy logikai kubitot kódoló,
gyengén önduális kvantumkódot készít. A jelen Idris-modul a nyolc- és
héthosszú esetet teljes véges felsorolással, a paritáshányadost is
láthatóvá téve ellenőrzi.

## A 240 gyök tizenöt rostja

A modul a Construction A minimális vektorait kombinatorikus
gyökleírókkal is felsorolja:

```text
8 tengely × 2 előjel                         = 16 koordinátagyök
14 súlynégyes kódszó × 16 előjelminta       = 224 kódszógyök
összesen                                    = 240 gyök
```

A koordinátagyökök címkéje a nullakódszó; a többi gyök címkéje a hozzá
tartozó súlynégyes kódszó. Így `1 + 14 = 15` rost keletkezik, és minden
rostban pontosan 16 gyök van. A csupa-egy kódszóval való eltolás a
rostcímkéket a `[8,4,4]` kód 15 nemnulla szavára viszi. A négydimenziós
bináris információs tér 15 nemnulla pontja ezért bijektíven címkézi a
rostokat.

Ugyanez a 15 nemnulla négydimenziós bináris pont a `[[15,1,3]]`
kvantum Reed–Muller-kód szokásos fizikaikubit-indexhalmaza. Ez pontos
közös véges indexhalmaz, de önmagában nem bizonyít kódekvivalenciát,
dinamikai azonosságot vagy közvetlen fizikai leképezést. A rostfelbontás
a választott Construction A koordinátakerettől függ; nem az E8
gyökrendszer keretfüggetlen felbontása.

Ezek a redukciós rostok nem ortogonális E8-keretek: egyazon rost két
gyökének skalárszorzata is lehet nemnulla. Az irodalomban ismert másik
felbontás a 120 antipodális gyöksugarat 15, egyenként 8 sugaras
ortogonális keretre bontja; az előjeleket visszaadva ott is `15 × 16`
adódik. A két azonos számosságú felbontást nem szabad azonosítani.

## A másik ág: E8-rácsból affin E8-karakter

Az `AffinE8KarakterLevezetes.idr` szigorúan külön tartja a két,
ugyanabból a klasszikus kódból induló konstrukciót:

```text
[8,4,4] kiterjesztett Hamming-kód
│
├─ kilyukasztás → [7,4,3] → Calderbank–Shor–Steane → [[7,1,3]]
│
└─ Construction A → E8-rács → rács-vertexoperátor-algebra
                              → affin E8 első szintű alapreprezentáció
```

Az első ág kvantumhibajavító kód. A második ág affin
reprezentációelmélet, és nem kódol logikai kubitot.

A Frenkel–Kac-tétel szerint az E8-rács vertexoperátor-algebrája
izomorf az affin E8 első szintű egyszerű
vertexoperátor-algebrájával:

```text
V(E8) ≅ L_E8(1, 0).
```

Ez az általános izomorfia irodalmi tétel, nem a jelen véges Idris-számítás
eredménye. A modul a karakter első együtthatóit vezeti le.

A `[8,4,4]` kód `1 + 14·y⁴ + y⁸` súlyfelsorolójából, a Construction A
páros és páratlan koordinátasorainak behelyettesítésével:

```text
E8 théta-sor = 1 + 240q + 2160q² + 6720q³ + …
```

A nyolc Cartan-oszcillátor harmadik fokig:

```text
oszcillátorsor = 1 + 8q + 44q² + 192q³ + …
```

A két sor konvolúciója:

```text
fokozott karakter = 1 + 248q + 4124q² + 34752q³ + …
```

Az első fok két független úton ugyanaz:

```text
Construction A: 240 gyök + 8 Cartan-áram = 248
karakter:       első nemállandó együttható = 248
```

A pontos második és harmadik fok:

```text
4124  = 2160 + 240·8 + 44
34752 = 6720 + 2160·8 + 240·44 + 192
```

A normalizált karakter elején álló `q^(-1/3)` tényező köbe `q^(-1)`.
Ezért a karakter belső sorának köbe:

```text
1 + 744q + 196884q² + 21493760q³ + …
```

ami a fokeltolás után a moduláris `j`-invariáns
`q^(-1), q⁰, q¹, q²` együtthatóit adja. A teljes
karakterköb-azonosság Kac tétele; az Idris-modul csak ezt a véges
kezdőszeletet ellenőrzi.

A központi töltést is két recept kényszeríti ugyanarra:

```text
rácsrecept:       rang(E8) = 8
Sugawara-recept:  1·248 / (1 + 30) = 8
```

Kategóriaelméletileg az E8-rács öndualitása miatt az első szintű
vertexoperátor-algebra holomorf: közönséges moduljainak fúziós
kategóriájában egyetlen egyszerű objektum van. Ez nem jelenti azt, hogy
az affin algebra teljes reprezentációkategóriája triviális, és nem
jelent kétdimenziós kvantumkódteret.

## Magyar térbeli esetek és a ternáris tetrakód

A `MagyarTeriTetrakod.idr` egy pontos, de korlátozott nyelvi
kódkonstrukciót ellenőriz. A három tértartomány és a három irányállapot
kilenc jelentést ad:

| Tértartomány | Forrás | Hely | Cél |
|---|---|---|---|
| belső tér | `-ból/-ből` | `-ban/-ben` | `-ba/-be` |
| felszín | `-ról/-ről` | `-on/-en/-ön/-n` | `-ra/-re` |
| közelség | `-tól/-től` | `-nál/-nél` | `-hoz/-hez/-höz` |

Ez a jelentéstér két trittel indexelhető:

```text
{belső tér, felszín, közelség}
×
{forrás, hely, cél}
≅ három elemű test × három elemű test.
```

A modul a ternáris `[4,2,3]` tetrakódot használja:

```text
(a,b) ↦ (a, a+b, a-b, b).
```

Véges felsorolással bizonyítja:

- a kilenc magyar térbeli eset és a kilenc tetrakódszó bijekcióját;
- a tetrakód minden kódszavának különbözőségét;
- a hármas minimumtávolságot;
- az önortogonalitást;
- hogy minden nemnulla kódszó súlya három;
- mind a hetvenkét lehetséges egytrit-hiba kijavítását;
- a Hamming-gömbök `9·(1+4·2)=81=3⁴` tökéletes lefedését.

A hat mozgásos eset három forrás–cél pár. Ezeket a választott
hatszögű gyökrendszer hat gyökéhez rendeli:

```text
(-1,0), (1,0), (0,-1), (0,1), (-1,-1), (1,1).
```

A `[[2,-1],[-1,2]]` Gram-mátrix szerint mind a hat gyök normanégyzete
kettő. Ez a hozzárendelés a három tartományt három gyökegyenesként, a
forrás–cél ellentétet előjelváltásként őrzi. Nem bizonyítja, hogy a
magyar nyelvtan teljes Weyl-csoporthatással vagy gyökösszeadással
rendelkezik.

Ugyanez a tetrakód négy hatszögű rács E8-cá ragasztásában is megjelenik.
A véges gyökszám:

```text
négy alaphatszög gyökei:         4·6 = 24
nyolc nemnulla ragasztási osztály:
                                8·3³ = 216
összesen:                       24+216 = 240.
```

A négy alaprács Gram-determinánsa `3⁴=81`; a kilences ragasztási index
négyzete szintén `9²=81`. A modul a kapott 240-at az előző,
Construction A-alapú 240-as gyökszámmal is bizonyítottan azonosítja.
Az általános `A₂⁴`-ragasztás és E8-rácsizomorfia jelentését az irodalom
adja, nem a puszta darabszám.

Ez a konstrukció két eltérő költséget választ szét:

- az allomorfok közös jelentéstípusra vonása és a morfológiai
  faktorizáció tömöríthet;
- a tetrakód két információtritet négy kódtritre bővít, tehát
  redundanciát ad és hibát javít, nem tömörít.

A tényleges nyelvmodellbeli nyereséghez még mérni kell a teljes
nyelvtan, lexikon, kivételek és maradék kódhosszát, valamint az új
szóalakokra való általánosítást.

## Mit nem jelent itt az E9 és a buborék?

Az affin E9 Kac–Moody-algebra nem „négy E8 és még egy bit”. Az E8
centrálisan kiterjesztett hurokalgebrája egy derivációval:

```text
E8 ⊗ összes egész Laurent-fok
  + központi generátor
  + fokszám-deriváció.
```

Ez végtelen dimenziós algebra. Egy megállási jel, Hamming-távolság vagy
harmincharmadik bit csak külön, véges modell lehet; E9-ként való
azonosításához hiányzik a hurokfok, a központi kettős kokiciklus, a
deriváció és a Lie-zárójel.

A húrelméleti „semmi buboréka” szintén más fogalom: olyan
vákuumbomlási geometria, amelyben a kompakt belső tér összehúzódik, és
egy világtérvégi perem keletkezik. A jelen paritásbuborék véges
kódelméleti hányados. A két fogalom között ez a modul nem állít
fizikai azonosságot.

## Mi következik ezután pontosan?

A kódparaméterekből:

```text
E8-rang                              = 8
fizikai kubitok száma                = 7
logikai kubitok száma                = 1
kvantumkód távolsága                 = 3
stabilizátorgenerátorok száma        = 6
hétszeres Hilbert-tér állapotai      = 2^7 = 128
nyolcbites tér állapotai             = 2^8 = 256
kiterjesztő paritásjelek száma       = 1
```

Ezután a megadott definíciókkal:

```text
128 + 2^3 + 1 = 137
(6 + 3) / (256 - 6) = 9 / 250
```

A gravitációs jelölt képlet számai szintén pontosan visszaírhatók:

```text
7 × (7 + 3 + 1) = 77
2^3 × (7 - 2)^2 = 200
2^3 × (7 - 2) = 40
```

Ezek számtani azonosságok. Nem bizonyítják, hogy a kapott számok fizikai
állandók.

## Hol áll meg a levezetés?

Az E8 Lie-algebra meghatározza a szimmetriát és a szerkezeti állandókat,
de nem határozza meg a mértékcsatolás kezdőértékét. A Yang–Mills-hatásban
ez külön paraméter:

```text
S = (1 / 2g²) ∫ tr(F ∧ *F)
```

Ezért ugyanaz az E8-algebra több különböző `g` csatolással is összefér.
A kis energiájú elektromágneses csatoláshoz ezen felül szükséges:

- a szimmetriatörési lánc;
- a részecskespektrum;
- a kompaktifikáció és annak modulusai;
- a csatolás renormálási futása;
- a küszöbkorrekciók;
- a mérési energiaskála.

A gravitáció konzisztens, dimenziótlan csatolása egy megadott `m`
tömegskálán:

```text
gravitációs csatolás(m) = G × m² / (ℏ × c)
```

Az E8–Steane-képlet dimenziótlan része ezért külön nevet kap:

```text
q = (77/200) × sqrt(3) × (259/250)^(1/40)
```

Ezt lehet egy meghatározandó modellskála gravitációs csatolásaként
értelmezni. Ekkor:

```text
modellskála / Planck-tömeg = sqrt(q)
```

Ez konzisztens és mértékegység-független, de még nem határozza meg G
dimenziós értékét. Dimenziótlan E8- és kódparaméterekből külön tömeg-
vagy hosszskála nélkül G nem állítható elő. Heterotikus modellekben a
szerkezeti összefüggés

```text
G₄ ~ húrcsatolás² × húrhossz⁸ / belső térfogat
```

alakú. Erősen csatolt E8×E8 modellekben a tizenegy-dimenziós
gravitációs csatolás, a Calabi–Yau-térfogat és az orbifoldsugár szükséges.
A modul ezért nem állít elő dimenziós G-jelöltet, és nem hasonlít ilyet
mérési értékhez. Kimenete kizárólag a mértékegység-független
`DimenzioNelKuliGravitaciosCsatolasJelolt` és a hozzá tartozó
Planck-tömegarány.

A

```text
(121/128)^(249 + ln(9/8))
```

korrekcióra a célzott irodalmi keresés nem talált független E8-spektrális
vagy hurokszámítási levezetést. A modul ezért ezt és a gravitációs képletet
`FizikaiFelvetes` típussal választja el a fordító által ellenőrzött résztől.

## Futtatás

```text
cd osveny_index/FuggetlenLevezetes
idris2 --build FuggetlenLevezetes.ipkg
./build/exec/e8-steane-levezetes
```

## Források

- David de Laat és Frank Vallentin, *A Breakthrough in Sphere Packing:
  The Search for Magic Functions*, 2.2. rész, arXiv:1607.02111.
  A `[8,4,4]` kód öndualitása, kétszeres párossága és az E8 Construction A
  előállítása.
- Shubham P. Jain és Victor V. Albert, *Transversal Clifford and
  T-gate codes of short length and high distance*, arXiv:2408.12752.
  Önduális klasszikus kód kilyukasztása, a duális kód mint stabilizátor,
  valamint a csupa-egy logikai Pauli-operátorok.
- Anatoly Dymarsky és Alfred Shapere, *Quantum stabilizer codes,
  lattices, and conformal field theories*, arXiv:2009.01244.
  A `[8,4,4]` súlyfelsorolója, Construction A, az E8 thétafüggvénye és
  a 240 gyök.
- Error Correction Zoo, `[[15,1,3]] quantum Reed–Muller code`.
  A fizikai kubitok indexelése a 15 nemnulla négydimenziós bináris
  ponttal.
- Guillaume Bossard és szerzőtársai, *Generalized diffeomorphisms for
  E9*, Physical Review D 96, 106022 (2017).
  Az affin E9 mint centrálisan kiterjesztett E8-hurokalgebra
  derivációval.
- Igor Frenkel és Victor Kac, *Basic Representations of Affine Lie
  Algebras and Dual Resonance Models*, Inventiones Mathematicae 62
  (1980).
  Az E8-rács vertexoperátoros megvalósítása mint az affin E8 első
  szintű alapreprezentációja.
- Victor Kac, *E8^(1) and the cube root of the modular invariant j*,
  Advances in Mathematics 35 (1980).
  Az első szintű affin E8-karakter és a moduláris `j`-invariáns
  köbgyökének azonossága.
- Chongying Dong és Geoffrey Mason, *Holomorphic vertex operator
  algebras of small central charge*, Pacific Journal of Mathematics
  213 (2004).
  A nyolcas központi töltésű holomorf vertexoperátor-algebra
  egyértelműsége.
- Noam Elkies, *The identification of three moduli spaces*,
  arXiv:math/9905195.
  E8 előállítása négy hatszögű rács tetrakódos ragasztásával, valamint
  a `24+216=240` gyökfelbontás.
- Dékány Éva és Hegedűs Veronika, a magyar térbeli esetek elemzése,
  DOI:10.1515/9789048544608-004.
  A térbeli esetek tartomány–irány faktorizációja.
- Ben Friedrich, Arthur Hebecker és Johannes Walcher, *Cobordism and
  Bubbles of Anything in the String Landscape*, Journal of High Energy
  Physics 2024, 127.
  A semmi buborékának és a világtérvégi peremnek a húrelméleti jelentése.
- Error Correction Zoo, `[8,4,4] extended Hamming code` és `E8 Gosset
  lattice`. A kód és az E8-rács Construction A kapcsolata.
- David Tong, *Gauge Theory*, 2. rész. A Yang–Mills-hatás külön `g`
  csatolási paramétere és annak energiaskála-függése.
- Ignatios Antoniadis, *Mass Scales in String and M-Theory*.
  A négydimenziós gravitációs és mértékcsatolások függése a húrelméleti
  skálától, a dilatontól és a kompaktifikációs térfogattól.
- National Institute of Standards and Technology,
  *Current advances: The fine-structure constant*. A finomszerkezeti
  állandó energiaskála-függése: kis energián körülbelül `1/137`,
  a W-bozon skáláján körülbelül `1/128`.
