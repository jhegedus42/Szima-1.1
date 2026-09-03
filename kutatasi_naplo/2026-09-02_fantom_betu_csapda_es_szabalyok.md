# Kutatási napló — 2026-09-02 — fantom-betű-csapda + az Idris2 bizonyítási szabályok

## A felhasználó javítása szó szerint (§N5)

«tizen-hat, nem t i z D e n h a t , nincsen D !»

## CSAPDA #18 — FANTOM-BETŰ

A «tizen» szóban NINCS D (t-i-z-e-n) — én «tizden»-t (T,I,Z,D,E,N)
írtam a szókonstansokba. A felhasználó szeme leplezte le (a §N14/3
elvének élő példája: a KIJELZÉS a végső bíra!). Javítva:
- szorzámTizenSzó = [T,I,Z,E,N] (5 betű)
- szorzámTizenhatSzó = [T,I,Z,E,N,H,A,T] (8 betű)
Futásidejű ellenőrzés: 16 → «tizenhat», 10 → «tíz», 20 → «húsz» ✓.
A csapda gyökere: a szó-literáloknak nincs fordítási idejű körút-tanúja
(a CsomagoltTipusok nem importálhatja a Határt — körkörös) — minden
új szót KIJELZÉSSEL kell ellenőrizni, vagy a tanút Határ-szintű
tesztbe tenni.

## ÚJ CSAPDA #18b — KÉZZEL SZÁMLÁLT MÉLYSÉG (a tízFelett leckéje)

A tízFelett «kilences» klauzulájában TÍZ wrapper volt (9 helyett) —
a kézzel számolt mélységi minták eltolódnak. A fordító «Missing cases»
listája pontosan megnevezte a lyukat (9-wrapper+SorNulla). Tanulság:
mélységi mintáknál a HIÁNYZÓ ESET listája a mélységmérő — ne kézzel
számolj, kérd el a fordítótól! (+ a sorSzöveggé case-ág-lapítása a
#8-as csapda szerint.)

## AZ IDRIS2 BIZONYÍTÁSI KEMÉNY SZABÁLYAI (a felhasználó kérésére)

«before continuing, read this and make a list of hard rules from them
https://idris2.readthedocs.io/en/latest/proofs/index.html»
«read the sub pages as well»

Mind az 5 aloldal elolvasva; 14 KEMÉNY SZABÁLY a
tanulsagok/Idris2BizonyitasSzabalyok.md fájlban — kulcsok:
konstruktív logika (nincs kizárt harmadik); Refl = definicionális
egyenlőség (normálalak!); A REKURZIÓ ARGUMENTUMA DÖNT (plus Z m
redukál, plus m Z nem — pontosan a sorÖsszeadás-örökségünk!);
indukció = strukturális rekurzió; a REWRITE IRÁNYA (sym a fordított
irányhoz; a helyettesítés a visszatérési típusban); sym/trans/stdlib
KÉSZEN van (§24: IMPORTÁLD!); total a bizonyításokra; heterogén
(~=~) egyenlőség a vektorFűzés-törvényekhez (400.03); interaktív
létra (luk → bontás → típus); vázolj előbb.

A szabályok AZONNAL be is váltak: a sorSzöveggé kompozicionális
terve a 14. szabály (vázlát gépileg) és a 4. (redukció iránya)
következménye — és a tízAlattiSzó/tízFelett/sorSzöveggé trio exit 0,
a sorSzöveggéTízTanú Refl-lel bizonyítva.

## Állapot

- Alap/CsomagoltTipusok exit 0 a sorSzöveggé-híddal (0–húsz, magyar
  szavakkal; a Sorszám-megjelenítés tíznél-telít kapuja feloldva).
- A 100.02 (Torusz átírása) előkészületei készen; a lépés következik.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
