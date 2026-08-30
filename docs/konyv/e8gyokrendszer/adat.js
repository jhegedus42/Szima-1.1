window.KONYV_ADAT = window.KONYV_ADAT || {};
window.KONYV_ADAT.e8gyokrendszer = {
  "címMagyar": "F2 — E8 gyökrendszer és W(E8)",
  "címKínai": "F2 — E8 根系与外尔群",
  "címNémet": "F2 — Das E8-Wurzelsystem und W(E8)",
  "címHéber": "‏F2 — מערכת שורשי E8 וחבורת וייל",
  "csoportok": [
    {"modul": "szima_ter/modul/E8Gyokok_v2.idr", "címMagyar": "A 240 gyök és a Weyl-csoport", "címKínai": "240 个根与外尔群", "címNémet": "Die 240 Wurzeln und die Weyl-Gruppe", "címHéber": "‏240 השורשים וחבורת וייל"},
    {"modul": "szima_ter/modul/E8BelsoSzorzat.idr", "címMagyar": "A belső szorzat-tábla és a tükrözések", "címKínai": "内积表与反射", "címNémet": "Die Innerprodukttabelle und die Spiegelungen", "címHéber": "‏טבלת המכפלה הפנימית וההשתקפויות"},
    {"modul": "szima_ter/modul/E8Iranymutato_v1.idr", "címMagyar": "Az E8 kivételességének mutatói", "címKínai": "E8 特殊性的指针", "címNémet": "Die Kennzahlen der Ausnahme", "címHéber": "‏מדדי ייחודיות E8"},
    {"modul": "szima_ter/modul/E8TizenhatPenge.idr", "címMagyar": "A 16 penge és a 256-os híd", "címKínai": "16 刃与 256 之桥", "címNémet": "Die 16 Blades und die 256-Brücke", "címHéber": "‏16 הלהבים וגשר 256"},
    {"modul": "szima_ter/modul/GyokSzo_v1.idr", "címMagyar": "A 240 szó — híd a nyelvhez (F4)", "címKínai": "240 个词——通往语言的桥（F4）", "címNémet": "Die 240 Wörter — Brücke zur Sprache (F4)", "címHéber": "‏240 המילים — גשר אל השפה (F4)"}
  ],
  "kártyák": [
    {
      "azonosító": "F2.01",
      "címMagyar": "A 8! = 40 320 — a permutációk száma, két független út",
      "címKínai": "8! = 40320——置换数，两条独立道路",
      "címNémet": "8! = 40320 — die Zahl der Permutationen auf zwei Wegen",
      "címHéber": "‏8! = 40320 — מספר התמורות בשני נתיבים עצמאיים",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizFaktorialisNyolc : Faktorialis 8 = 40320",
      "kernelSzerepe": "a kernel a Faktorialis 8 rekurziót nyolc lépésben normalizálja, és összeveti a 40320 literállal",
      "besorolás": "VALÓDI (rekurziós definíció ⟷ literál)",
      "definíciók": ["public export", "Faktorialis : Nat -> Integer", "Faktorialis Z = 1", "Faktorialis (S n) = cast (S n) * Faktorialis n"],
      "lépések": [
        {"képlet": "Faktorialis 8 = 8 · 7 · 6 · 5 · 4 · 3 · 2 · 1", "érték": "40320", "miért": "a rekurzió kibontva: minden S n szint egy szorzás (az Integer kernel bináris — GMP)"},
        {"képlet": "2⁷ · 3² · 5 · 7 = 128 · 9 · 5 · 7", "érték": "40320", "miért": "a prímfelbontás útja — a második, fogalmilag más konstrukció (bizFaktorialisPrim, F2.02)"},
        {"képlet": "Δ = 40320 − 40320", "érték": "0", "miért": "a két független út maradéka: nulla — a híd áll (§18)"}
      ],
      "szimuláció": "a Python math.factorial(8) = 40320 és 128·9·5·7 = 40320; Δ = 0 (maradekok.csv)",
      "grafikonok": [
        {"cím": "SZERKEZET — A faktoriális létra: 1!, 2!, …, 8!", "fájl": "F2.01_1.png"},
        {"cím": "SZÁMOLÁS — Két út a 40320-hez: rekurzió ⟷ prímek", "fájl": "F2.01_2.png"},
        {"cím": "ELLENŐRZÉS — Maradékok: f8 ⟷ kernel, prím-út ⟷ kernel (Δ = 0)", "fájl": "F2.01_3.png"},
        {"cím": "SPEKTRUM — A 40320 prímtornyai: 2⁷, 3², 5, 7", "fájl": "F2.01_4.png"},
        {"cím": "HÍD — Híd: Idris-Refl Faktorialis 8 ⟷ Python math.factorial(8)", "fájl": "F2.01_5.png"}
      ],
      "összefoglalóMagyar": "A 8! a W(D8) előjeles permutációinak magja: két független úton (rekurzió és prímfelbontás) ugyanaz a 40320 adódik — a kernel és a szimuláció maradéka nulla.",
      "összefoglalóKínai": "8! 是 W(D8) 带符号排列的核心：递归与质因数分解两条路都得出 40320，残差为零。",
      "összefoglalóNémet": "8! ist der Kern der vorzeichenbehafteten Permutationen von W(D8): Rekursiver und Primweg ergeben 40320, Rest null.",
      "összefoglalóHéber": "‏8! הוא ליבת התמורות המסומנות של W(D8): שני נתיבים עצמאיים נותנים 40320, שארית אפס."
    },
    {
      "azonosító": "F2.02",
      "címMagyar": "A 8! prímfelbontása: 2⁷·3²·5·7 = 128·9·5·7 = 40 320",
      "címKínai": "8! 的质因数分解：2⁷·3²·5·7",
      "címNémet": "Die Primfaktorzerlegung von 8!: 2⁷·3²·5·7",
      "címHéber": "‏פירוק 8! לגורמים ראשוניים: 2⁷·3²·5·7",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizFaktorialisPrim : 128 * 9 * 5 * 7 = 40320",
      "kernelSzerepe": "a kernel négy egész szorzatát normalizálja és összeveti a 40320 literállal",
      "besorolás": "KÉT ÚT-HÍD (prímfelbontás ⟷ rekurzió)",
      "definíciók": ["public export", "bizFaktorialisPrim : 128 * 9 * 5 * 7 = 40320", "bizFaktorialisPrim = Refl"],
      "lépések": [
        {"képlet": "2⁷ = 128", "érték": "128", "miért": "a kettes prím hetedik hatványa"},
        {"képlet": "3² = 9, 5, 7", "érték": "21", "miért": "a további prímtényezők (3² + 5 + 7 = 21)"},
        {"képlet": "128 · 9 · 5 · 7", "érték": "40320", "miért": "a prím-út szorzata"},
        {"képlet": "Δ = prím-út − Faktorialis 8", "érték": "0", "miért": "a maradék nulla: a prímfelbontás és a rekurzió ugyanazt a számot adja"}
      ],
      "szimuláció": "a Python 128·9·5·7 = 40320 = math.factorial(8); Δ = 0 (maradekok.csv)",
      "grafikonok": [
        {"cím": "SZERKEZET — A prímtorony: 2⁷ = 128, 3² = 9, 5, 7", "fájl": "F2.02_1.png"},
        {"cím": "SZÁMOLÁS — A prím-út szorzata: 128·9·5·7", "fájl": "F2.02_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: prím-út ⟷ kernel 40320 (Δ = 0)", "fájl": "F2.02_3.png"},
        {"cím": "SPEKTRUM — A faktoriális létra 1!…8!", "fájl": "F2.02_4.png"},
        {"cím": "HÍD — Híd: prím-út ⟷ rekurzió (8!)", "fájl": "F2.02_5.png"}
      ],
      "összefoglalóMagyar": "A 40320 prímfelbontása (2⁷·3²·5·7) fogalmilag más konstrukció, mint a rekurzió — a kernel mégis ugyanarra kényszeríti a kettőt: ez a két-út-híd mintapéldája.",
      "összefoglalóKínai": "40320 的质因数分解与递归是概念上不同的构造，内核强制二者一致——两路桥的范例。",
      "összefoglalóNémet": "Die Primzerlegung und die Rekursion sind verschiedene Konstruktionen, die der Kernel zur selben Zahl zwingt — das Musterbeispiel einer Zwei-Wege-Brücke.",
      "összefoglalóHéber": "‏הפירוק לגורמים והרקורסיה בנויים אחרת, אך הליבה מכריחה אותם להתלכד — מופת לגשר שני הנתיבים."
    },
    {
      "azonosító": "F2.03",
      "címMagyar": "A típus-1 gyökök száma: C(8,2)·2² = 28·4 = 112",
      "címKínai": "第一类根的个数：C(8,2)·2² = 112",
      "címNémet": "Die Zahl der Typ-1-Wurzeln: C(8,2)·2² = 112",
      "címHéber": "‏מספר שורשי הטיפוס הראשון: 112",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizTipusEgy : 28 * 4 = 112",
      "kernelSzerepe": "a kernel a 28·4 szorzatot normalizálja és összeveti a 112 literállal; futásidőben a felsorolt tipus1Gyokok hossza is 112",
      "besorolás": "KÉT ÚT (kombinatorika ⟷ enumeráció)",
      "definíciók": ["public export", "pozicioParok : List (Integer, Integer)", "pozicioParok = [ (i, j) | i <- [1..8], j <- [1..8], i < j ]", "elojelParok : List (Integer, Integer)", "elojelParok = [(1, 1), (1, -1), (-1, 1), (-1, -1)]", "tipus1Gyokok : List E8Gyok"],
      "lépések": [
        {"képlet": "C(8,2) — a pozíciópárok száma", "érték": "28", "miért": "két nemnulla koordináta helye a 8 közül: 8·7/2 (futásidőben mérve)"},
        {"képlet": "2² — az előjelpárok száma", "érték": "4", "miért": "(+,+), (+,−), (−,+), (−,−) — a két nemnulla hely előjele"},
        {"képlet": "28 · 4", "érték": "112", "miért": "a kombinatorikai szorzat"},
        {"képlet": "length tipus1Gyokok (enumeráció)", "érték": "112", "miért": "a kernel a felépített lista hosszát számolja — a második út"}
      ],
      "szimuláció": "a Python ugyanezzel a két úttal: 28 pozíciópár × 4 előjel = 112 enumerált gyök; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A 240 gyök 2D-petri-vetülete (kiválasztott koordináta-sík)", "fájl": "F2.03_1.png"},
        {"cím": "SZÁMOLÁS — 28 pozíciópár · 4 előjelpár → 112 típus-1 gyök", "fájl": "F2.03_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: típus-1 enumeráció ⟷ kernel 112 (Δ = 0)", "fájl": "F2.03_3.png"},
        {"cím": "SPEKTRUM — A két gyöktípus halmazai: 112 egész + 128 fél-egész", "fájl": "F2.03_4.png"},
        {"cím": "HÍD — Híd: kombinatorika 28·4 ⟷ enumeráció", "fájl": "F2.03_5.png"}
      ],
      "összefoglalóMagyar": "A 112 típus-1 gyök (±1,±1,0⁶-permutációk a 2-szeres skálán) két úton áll elő: a C(8,2)·2² kombinatorikából és a tényleges felsorolásból — a kettő maradéka nulla.",
      "összefoglalóKínai": "112 个第一类根由两条路得出：组合 C(8,2)·2² 与实际枚举，残差为零。",
      "összefoglalóNémet": "Die 112 Typ-1-Wurzeln entstehen auf zwei Wegen: Kombinatorik und Enumeration, Rest null.",
      "összefoglalóHéber": "‏112 שורשי טיפוס 1 נובעים בשני נתיבים: קומבינטוריקה וספירה, שארית אפס."
    },
    {
      "azonosító": "F2.04",
      "címMagyar": "A típus-2 gyökök száma: 2⁸ = 256 → páros mínusszal 128",
      "címKínai": "第二类根的个数：256 个符号组合中偶负号者 128",
      "címNémet": "Die Zahl der Typ-2-Wurzeln: 256 Kombinationen, 128 mit gerader Minuszahl",
      "címHéber": "‏מספר שורשי הטיפוס השני: 128",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizTipusKetto : 256 = 128 + 128",
      "kernelSzerepe": "a kernel a 256 = 128 + 128 egyenletet normalizálja: a páros és páratlan előjel-kombinációk szétválasztása",
      "besorolás": "VALÓDI (páros paritás felezés)",
      "definíciók": ["public export", "osszesElojel : List (List Integer)", "osszesElojel = [ [s1, …, s8] | s1 <- [1, -1], …, s8 <- [1, -1] ]", "parosParitas : List Integer -> Bool", "tipus2Gyokok : List E8Gyok", "tipus2Gyokok = filter parosGyok (concatMap listaGyokke osszesElojel)"],
      "lépések": [
        {"képlet": "2⁸ — az összes előjel-kombináció", "érték": "256", "miért": "minden koordináta ±1 lehet — a fél-egész gyökök dupla skálája"},
        {"képlet": "páros mínusszal (0, 2, 4, 6, 8 mínusz)", "érték": "128", "miért": "a parosParitas szűrő: a mínuszok száma páros — a spinor-szerkezet feltétele"},
        {"képlet": "256 = 128 + 128", "érték": "256", "miért": "a páros és páratlan kombinációk fele-fele arányban oszlanak meg"},
        {"képlet": "length tipus2Gyokok", "érték": "128", "miért": "a felsorolás méri a 128-at"}
      ],
      "szimuláció": "a Python 256 kombinációt generál és megszámolja a párosakat: 128; a mínusz-szám szerinti eloszlás 1, 28, 70, 28, 1 (0, 2, 4, 6, 8 mínusszal)",
      "grafikonok": [
        {"cím": "SZERKEZET — A két gyöktípus halmazai: 112 egész + 128 fél-egész", "fájl": "F2.04_1.png"},
        {"cím": "SZÁMOLÁS — 2⁸ kombináció → 128 páros + 128 páratlan", "fájl": "F2.04_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: típus-2 enumeráció ⟷ kernel 128 (Δ = 0)", "fájl": "F2.04_3.png"},
        {"cím": "SPEKTRUM — A mínuszok számának eloszlása a 128 gyökön", "fájl": "F2.04_4.png"},
        {"cím": "HÍD — Híd: 256/2 = 128 ⟷ enumeráció", "fájl": "F2.04_5.png"}
      ],
      "összefoglalóMagyar": "A fél-egész gyökök (±½)⁸ a dupla skálán (±1)⁸: a 256 előjel-kombinációból a páros mínusszámúak maradnak — ez a 128, a demiocteract csúcsai.",
      "összefoglalóKínai": "半整数根（±½）⁸ 在双倍尺度上：256 个组合中偶负号者保留——即 128，即半八维立方体的顶点。",
      "összefoglalóNémet": "Die halbzahligen Wurzeln: von 256 Kombinationen bleiben die mit gerader Minuszahl — die 128 Ecken des Demiocteracts.",
      "összefoglalóHéber": "‏שורשי החצאים: מתוך 256 צירופי סימן נותרים אלה עם מספר זוגי של מינוסים — 128 קודקודי הדמיאוקטרקט."
    },
    {
      "azonosító": "F2.05",
      "címMagyar": "A 240 gyök: 112 + 128 = 240 — a 240 szimbólum",
      "címKínai": "240 个根：112 + 128 = 240——240 个符号",
      "címNémet": "Die 240 Wurzeln: 112 + 128 = 240 — die 240 Symbole",
      "címHéber": "‏240 השורשים: 112 + 128 = 240",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizE8GyokSzam : 112 + 128 = 240",
      "kernelSzerepe": "a kernel a két típus összegét normalizálja; futásidőben az e8Gyokok lista hossza is 240",
      "besorolás": "KÉT ÚT (típus-szétválasztás ⟷ teljes enumeráció)",
      "definíciók": ["public export", "tipus1Gyokok : List E8Gyok   -- 112", "tipus2Gyokok : List E8Gyok   -- 128", "e8Gyokok : List E8Gyok", "e8Gyokok = tipus1Gyokok ++ tipus2Gyokok"],
      "lépések": [
        {"képlet": "112 (típus-1)", "érték": "112", "miért": "a (±1,±1,0⁶)-permutációk (F2.03)"},
        {"képlet": "128 (típus-2)", "érték": "128", "miért": "a páros (±½)⁸ gyökök (F2.04)"},
        {"képlet": "112 + 128", "érték": "240", "miért": "a típusok összege"},
        {"képlet": "length e8Gyokok", "érték": "240", "miért": "a teljes felsorolás hossza — a híd másik oldala"}
      ],
      "szimuláció": "a Python mindkét típust felsorolja és összefűzi: 240; minden norma² = 8 (0 hibás)",
      "grafikonok": [
        {"cím": "SZERKEZET — A 240 gyök 2D-petri-vetülete", "fájl": "F2.05_1.png"},
        {"cím": "SZÁMOLÁS — 112 + 128 → 240", "fájl": "F2.05_2.png"},
        {"cím": "ELLENŐRZÉS — Maradékok: típus-1, típus-2, e8 ⟷ kernel (Δ = 0)", "fájl": "F2.05_3.png"},
        {"cím": "SPEKTRUM — norma²-hisztogram mind a 240 gyökön (mind = 8)", "fájl": "F2.05_4.png"},
        {"cím": "HÍD — Híd: 112+128 kombinatorika ⟷ enumeráció 240", "fájl": "F2.05_5.png"}
      ],
      "összefoglalóMagyar": "Az E8 gyökrendszere 240 szimbólum: 112 egész + 128 fél-egész gyök. A típus-szétválasztás és a teljes felsorolás ugyanoda érkezik — ez a fejezet központi hídja.",
      "összefoglalóKínai": "E8 根系是 240 个符号：112 整数根 + 128 半整数根；类型分解与完整枚举殊途同归。",
      "összefoglalóNémet": "Das E8-Wurzelsystem: 240 Symbole aus 112 ganzen und 128 halbzahligen Wurzeln — Trennung und Enumeration treffen sich.",
      "összefoglalóHéber": "‏מערכת שורשי E8: 240 סמלים — 112 שלמים ו־128 חצאים; הפירוק והספירה נפגשים."
    },
    {
      "azonosító": "F2.06",
      "címMagyar": "A 240 + 16 = 256 híd előszava: gyökök + pengék = a teljes bájt",
      "címKínai": "240 + 16 = 256 之桥的序言：根 + 刃 = 完整字节",
      "címNémet": "Vorschau der 256-Brücke: Wurzeln + Blades = das volle Byte",
      "címHéber": "‏הקדמת גשר 256: שורשים + להבים = בייט מלא",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizGyokPluszTizenhat : 240 + 16 = 256",
      "kernelSzerepe": "a kernel a 240+16 összeget normalizálja a 256 literálhoz — a Cl(4) pengékkel közös híd (részletek: F2.34)",
      "besorolás": "KÉT ÚT-HÍD (enumeráció ⟷ hatvány)",
      "definíciók": ["public export", "bizGyokPluszTizenhat : 240 + 16 = 256", "bizGyokPluszTizenhat = Refl"],
      "lépések": [
        {"képlet": "240 (E8 gyökök)", "érték": "240", "miért": "a tartalom (F2.05)"},
        {"képlet": "16 (Cl(4) pengék)", "érték": "16", "miért": "a keret: 1+4+6+4+1 (F2.27)"},
        {"képlet": "240 + 16", "érték": "256", "miért": "tartalom + keret"},
        {"képlet": "2⁸", "érték": "256", "miért": "a teljes bájt — a második út"}
      ],
      "szimuláció": "a Python len(e8) + len(pengék) = 240 + 16 = 256 = 2**8; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — 240 gyök + 16 penge egy rácsban (a 256 mező)", "fájl": "F2.06_1.png"},
        {"cím": "SZÁMOLÁS — 240 gyök + 16 penge → 256", "fájl": "F2.06_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: híd ⟷ kernel 256 (Δ = 0)", "fájl": "F2.06_3.png"},
        {"cím": "SPEKTRUM — A 16 penge fokszámai: (1, 4, 6, 4, 1)", "fájl": "F2.06_4.png"},
        {"cím": "HÍD — Híd: enumeráció 240+16 ⟷ 2⁸", "fájl": "F2.06_5.png"}
      ],
      "összefoglalóMagyar": "A 240 szimbólum (tartalom) és a 16 penge (keret) együtt a 256-os tér: a bájt. A híd teljes kifejtése a F2.34 kártyán.",
      "összefoglalóKínai": "240 个符号（内容）与 16 刃（框架）合成 256 空间：一个字节。完整展开见 F2.34。",
      "összefoglalóNémet": "240 Symbole (Inhalt) und 16 Blades (Rahmen) ergeben den 256-Raum: das Byte — voll entfaltet auf F2.34.",
      "összefoglalóHéber": "‏240 סמלים (תוכן) ו־16 להבים (מסגרת) יוצרים את מרחב 256: הבייט — הפריסה המלאה ב־F2.34."
    },
    {
      "azonosító": "F2.07",
      "címMagyar": "A típus-1 norma: gyokNorma (2,2,0⁶) = 8 — a 2-szeres skála",
      "címKínai": "第一类根的范数：8（双倍尺度）",
      "címNémet": "Die Norm einer Typ-1-Wurzel: 8 (doppelte Skala)",
      "címHéber": "‏נורמת שורש טיפוס 1: 8",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizTipus1Norma : gyokNorma (tipus1GyokTeljes 1 2 1 1) = 8",
      "kernelSzerepe": "a kernel a konstruktor-alkalmazást kibontja és a nyolc négyzetösszeget normalizálja a 8 literálhoz",
      "besorolás": "VALÓDI (definíció ⟷ literál)",
      "definíciók": ["public export", "gyokNorma : E8Gyok -> Integer", "gyokNorma (E8GyokKonstruktor a b c d e f g h) = a*a + b*b + … + h*h", "tipus1GyokTeljes : Integer -> Integer -> Integer -> Integer -> E8Gyok"],
      "lépések": [
        {"képlet": "tipus1GyokTeljes 1 2 1 1 → (2,2,0,0,0,0,0,0)", "érték": "(2,2,0,0,0,0,0,0)", "miért": "az 1. helyen 2·(+1), a 2. helyen 2·(+1), máshol 0"},
        {"képlet": "2² + 2² + 0²·6", "érték": "8", "miért": "a nyolc koordináta négyzetének összege a 2-szeres skálán"},
        {"képlet": "értelmezés: norma² = 2 az eredeti skálán", "érték": "8 = 2·2", "miért": "a 2-szeres skála miatt minden szorzatérték 4-szeres — a simply-laced norma 2"}
      ],
      "szimuláció": "a Python mind a 240 gyökön sum(v²)-t számol: mind 8, hibás 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A példagyök (2,2,0⁶) a petri-vetületben", "fájl": "F2.07_1.png"},
        {"cím": "SZÁMOLÁS — A négyzettagok: 2² + 2² + 0·6", "fájl": "F2.07_2.png"},
        {"cím": "ELLENŐRZÉS — Hibás normák száma a 240 gyökön (várható 0)", "fájl": "F2.07_3.png"},
        {"cím": "SPEKTRUM — norma²-hisztogram mind a 240 gyökön (mind = 8)", "fájl": "F2.07_4.png"},
        {"cím": "HÍD — Híd: kernel gyokNorma ⟷ szimuláció sum(v²)", "fájl": "F2.07_5.png"}
      ],
      "összefoglalóMagyar": "Az E8 egyszerűen fűzött (simply-laced): minden gyök normája azonos. A 2-szeres skálán ez 8 — az egész tábla ezen a skálán egész marad.",
      "összefoglalóKínai": "E8 为单连（simply-laced）：所有根范数相同；双倍尺度下为 8，使全表保持整数。",
      "összefoglalóNémet": "E8 ist simply-laced: alle Wurzeln haben dieselbe Norm — auf der doppelten Skala 8, damit alles ganzzahlig bleibt.",
      "összefoglalóHéber": "‏E8 פשוטת־קשר: לכל השורשים אותה נורמה — בסקאלה הכפולה 8, כדי שהכול יישאר שלם."
    },
    {
      "azonosító": "F2.08",
      "címMagyar": "A típus-2 norma: gyokNorma (1⁸) = 8 — a fél-egész gyök is azonos",
      "címKínai": "第二类根的范数也是 8",
      "címNémet": "Die Norm einer Typ-2-Wurzel: ebenfalls 8",
      "címHéber": "‏גם נורמת שורש טיפוס 2 היא 8",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizTipus2Norma : gyokNorma (E8GyokKonstruktor 1 1 1 1 1 1 1 1) = 8",
      "kernelSzerepe": "a kernel a nyolc 1² összeget normalizálja a 8 literálhoz",
      "besorolás": "VALÓDI (definíció ⟷ literál)",
      "definíciók": ["public export", "bizTipus2Norma : gyokNorma (E8GyokKonstruktor 1 1 1 1 1 1 1 1) = 8", "bizTipus2Norma = Refl"],
      "lépések": [
        {"képlet": "(1,1,1,1,1,1,1,1) — a (±½)⁸ gyök a 2-szeres skálán", "érték": "(1,1,1,1,1,1,1,1)", "miért": "az (½⁸) gyök koordinátánként duplázva"},
        {"képlet": "1² · 8", "érték": "8", "miért": "nyolc egyes négyzete"},
        {"képlet": "konklúzió: a két típus normája azonos", "érték": "8 = 8", "miért": "a típus-1 és típus-2 gyökök azonos hosszúak — ez teszi lehetővé a közös skálát"}
      ],
      "szimuláció": "a Python a típus-2 gyökökön is sum(v²) = 8-t mér: hibás 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A fél-egész gyökök halmaza", "fájl": "F2.08_1.png"},
        {"cím": "SZÁMOLÁS — 1² × 8 négyzettag", "fájl": "F2.08_2.png"},
        {"cím": "ELLENŐRZÉS — Hibás normák a 240 gyökön (várható 0)", "fájl": "F2.08_3.png"},
        {"cím": "SPEKTRUM — norma²-hisztogram mind a 240 gyökön", "fájl": "F2.08_4.png"},
        {"cím": "HÍD — Híd: kernel gyokNorma (1⁸) ⟷ szimuláció", "fájl": "F2.08_5.png"}
      ],
      "összefoglalóMagyar": "A (±½)⁸ gyökök a 2-szeres skálán (±1)⁸: nyolc egyes négyzete ugyanannyi, mint a típus-1 gyököknél — a két család egyformán hosszú.",
      "összefoglalóKínai": "(±½)⁸ 在双倍尺度为 (±1)⁸：八个 1² 之和与第一类根相同——两族等长。",
      "összefoglalóNémet": "(±½)⁸ wird auf der doppelten Skala zu (±1)⁸: acht Einsquadrate, gleich lang wie Typ 1.",
      "összefoglalóHéber": "‏(±½)⁸ בסקאלה הכפולה הוא (±1)⁸: שמונה ריבועי אחד — אותו אורך כמו טיפוס 1."
    },
    {
      "azonosító": "F2.09",
      "címMagyar": "W(D8) = 2⁷·8! = 5 160 960 — az előjeles permutációk csoportja",
      "címKínai": "W(D8) = 2⁷·8! = 5160960",
      "címNémet": "W(D8) = 2⁷·8! = 5160960 — die vorzeichenbehafteten Permutationen",
      "címHéber": "‏W(D8) = 2⁷·8! = 5160960",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizWeylD8 : WeylD8Rend = 5160960",
      "kernelSzerepe": "a kernel a WeylD8Rend = 128 · Faktorialis 8 szorzatot normalizálja a literálhoz (Integer-kernel — a v1 Nat-fagyásának gyógyíra)",
      "besorolás": "KÉT ÚT (2⁷·8! struktúra ⟷ literál)",
      "definíciók": ["public export", "WeylD8Rend : Integer", "WeylD8Rend = 128 * Faktorialis 8"],
      "lépések": [
        {"képlet": "2⁷ = 128 — az előjelek cseréi", "érték": "128", "miért": "nyolc koordináta előjele önállóan cserélhető"},
        {"képlet": "8! = 40320 — a permutációk", "érték": "40320", "miért": "a koordináták helycseréi (F2.01)"},
        {"képlet": "128 · 40320", "érték": "5160960", "miért": "a D8 rács szimmetriáinak száma"},
        {"képlet": "ellenőrzés futásidőben", "érték": "5160960", "miért": "a main kiírja: 5160960"}
      ],
      "szimuláció": "a Python 128·math.factorial(8) = 5160960; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A Weyl-lánc: 2⁷ → 8! → 135 → W(D8) → W(E8)", "fájl": "F2.09_1.png"},
        {"cím": "SZÁMOLÁS — 2⁷ · 8! → 5 160 960", "fájl": "F2.09_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: W(D8) ⟷ kernel (Δ = 0)", "fájl": "F2.09_3.png"},
        {"cím": "SPEKTRUM — A 40320 prímtornyai: 2⁷, 3², 5, 7", "fájl": "F2.09_4.png"},
        {"cím": "HÍD — Híd: struktúra 2⁷·8! ⟷ kernel WeylD8Rend", "fájl": "F2.09_5.png"}
      ],
      "összefoglalóMagyar": "A D8 rács szimmetriacsoportja a 240 gyök 112 egész tagját őrzi: előjelcsere × permutáció. A nagy szám Integer-kernellel bizonyítható — ez a v1 fagyásának tanulsága.",
      "összefoglalóKínai": "D8 格的对称群由符号交换与排列构成；大数用 Integer 内核证明——v1 冻结之训。",
      "összefoglalóNémet": "Die Symmetriegruppe des D8-Gitters: Vorzeichenwechsel × Permutation; große Zahlen mit Integer-Kernel — die Lehre des eingefrorenen v1.",
      "összefoglalóHéber": "‏חבורת הסימטריה של סריג D8: החלפת סימנים × תמורות; מספרים גדולים בליבת Integer — מוראת v1."
    },
    {
      "azonosító": "F2.10",
      "címMagyar": "A trialitás-faktor: 135 = 3³·5",
      "címKínai": "三重性因子：135 = 3³·5",
      "címNémet": "Der Trialitätsfaktor: 135 = 3³·5",
      "címHéber": "‏גורם הטריאליות: 135 = 3³·5",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizSzazharmincot : TrialitySzazharmincot = 135",
      "kernelSzerepe": "a kernel a 3·3·3·5 szorzatot normalizálja a 135 literálhoz",
      "besorolás": "VALÓDI (szorzat ⟷ literál)",
      "definíciók": ["public export", "TrialitySzazharmincot : Integer", "TrialitySzazharmincot = 3 * 3 * 3 * 5"],
      "lépések": [
        {"képlet": "3 · 3 · 3 = 27", "érték": "27", "miért": "a triality harmadik hatványa"},
        {"képlet": "27 · 5 = 135", "érték": "135", "miért": "szorozva az ötössel"},
        {"képlet": "W(E8) = W(D8) · 135", "érték": "696729600", "miért": "a D8-csoport és az E8-csoport közti arány (F2.11)"}
      ],
      "szimuláció": "a Python 3·3·3·5 = 135; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A trialitás-faktor felépítése: 3·3·3·5", "fájl": "F2.10_1.png"},
        {"cím": "SZÁMOLÁS — 27 · 5 → 135", "fájl": "F2.10_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: trialitás ⟷ kernel (Δ = 0)", "fájl": "F2.10_3.png"},
        {"cím": "SPEKTRUM — A prímtornyok: 3³ és 5", "fájl": "F2.10_4.png"},
        {"cím": "HÍD — Híd: 3·3·3·5 ⟷ kernel TrialitySzazharmincot", "fájl": "F2.10_5.png"}
      ],
      "összefoglalóMagyar": "A 135 az a faktor, amellyel a D8 szimmetriák tere E8-va bővül: a spinor-tér trialitása (3³) és az ötös tükör szorzata.",
      "összefoglalóKínai": "135 是 D8 对称扩张为 E8 的因子：旋量空间三重性（3³）与五重镜之积。",
      "összefoglalóNémet": "135 ist der Faktor, der D8 zu E8 erweitert: die Trialität des Spinnorraums (3³) mal fünf.",
      "összefoglalóHéber": "‏135 הוא הגורר שמרחיב את D8 ל־E8: טריאליות מרחב הספינורים (3³) כפול חמש."
    },
    {
      "azonosító": "F2.11",
      "címMagyar": "W(E8) = 696 729 600 = W(D8)·135 — a struktúra-út",
      "címKínai": "W(E8) = 696729600 = W(D8)·135——结构之路",
      "címNémet": "W(E8) = 696729600 = W(D8)·135 — der Strukturweg",
      "címHéber": "‏W(E8) = 696729600 = W(D8)·135",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizWeylE8 : WeylE8Rend = 696729600",
      "kernelSzerepe": "a kernel a WeylD8Rend · TrialitySzazharmincot szorzatot normalizálja a 696729600 literálhoz",
      "besorolás": "KÉT ÚT (struktúra-szorzat ⟷ literál)",
      "definíciók": ["public export", "WeylE8Rend : Integer", "WeylE8Rend = WeylD8Rend * TrialitySzazharmincot"],
      "lépések": [
        {"képlet": "W(D8) = 5 160 960", "érték": "5160960", "miért": "az előjeles permutációk (F2.09)"},
        {"képlet": "135 = 3³·5", "érték": "135", "miért": "a trialitás-faktor (F2.10)"},
        {"képlet": "5 160 960 · 135", "érték": "696729600", "miért": "a struktúra-út szorzata"},
        {"képlet": "696 729 600 — NEM túl sok", "érték": "696729600", "miért": "a kernel ezredmásodperc alatt normalizálja (Integer, nem Nat)"}
      ],
      "szimuláció": "a Python weylD8 · trialitás = 696729600; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A Weyl-lánc: 2⁷ → 8! → 135 → W(D8) → W(E8)", "fájl": "F2.11_1.png"},
        {"cím": "SZÁMOLÁS — W(D8) · 135 → 696 729 600", "fájl": "F2.11_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: W(E8) ⟷ kernel (Δ = 0)", "fájl": "F2.11_3.png"},
        {"cím": "SPEKTRUM — A prímtornyok: 2¹⁴, 3⁵, 5², 7", "fájl": "F2.11_4.png"},
        {"cím": "HÍD — Híd: struktúra-út ⟷ kernel WeylE8Rend", "fájl": "F2.11_5.png"}
      ],
      "összefoglalóMagyar": "Az E8 Weyl-csoportjának rendje a struktúra-úton: az előjeles permutációk (W(D8)) szorozva a trialitás-faktorral (135). A 696 729 600 nem visszaélés — a kernel kiszámolja.",
      "összefoglalóKínai": "E8 外尔群之阶沿结构之路：带符号排列（W(D8)）乘以三重性因子 135；696729600 由内核直接算出。",
      "összefoglalóNémet": "Die Ordnung der E8-Weyl-Gruppe auf dem Strukturweg: W(D8) mal Trialitätsfaktor 135 — 696729600 rechnet der Kernel direkt aus.",
      "összefoglalóHéber": "‏סדר חבורת וייל של E8 בדרך המבנה: W(D8) כפול גורם הטריאליות 135 — 696729600 הליבה מחשבת ישירות."
    },
    {
      "azonosító": "F2.12",
      "címMagyar": "W(E8) = 2¹⁴·3⁵·5²·7 = 696 729 600 — KÉT FÜGGETLEN ÚT, EGY HÍD",
      "címKínai": "W(E8) = 2¹⁴·3⁵·5²·7——两条独立道路，一座桥",
      "címNémet": "W(E8) = 2¹⁴·3⁵·5²·7 — zwei unabhängige Wege, eine Brücke",
      "címHéber": "‏W(E8) = 2¹⁴·3⁵·5²·7 — שני נתיבים, גשר אחד",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizWeylE8Prim : 16384 * 243 * 25 * 7 = 696729600",
      "kernelSzerepe": "a kernel a prímtényezős szorzatot normalizálja ugyanahhoz a 696729600-hoz, mint a struktúra-út (F2.11) — a két fogalmilag különböző konstrukció kényszerített találkozása",
      "besorolás": "KÉT ÚT-HÍD (struktúra ⟷ prímfelbontás)",
      "definíciók": ["public export", "bizWeylE8 : WeylE8Rend = 696729600", "bizWeylE8Prim : 16384 * 243 * 25 * 7 = 696729600", "bizWeylE8Prim = Refl"],
      "lépések": [
        {"képlet": "2¹⁴ = 16384", "érték": "16384", "miért": "a kettes prím tizennegyedik hatványa"},
        {"képlet": "3⁵ = 243, 5² = 25, 7", "érték": "42525", "miért": "a további prímtényezők szorzata"},
        {"képlet": "16384 · 243 · 25 · 7", "érték": "696729600", "miért": "a prím-út szorzata"},
        {"képlet": "Δ = prím-út − struktúra-út", "érték": "0", "miért": "a maradék nulla: a struktúra (W(D8)·135) és a prímfelbontás ugyanazt a csoportrendet adja"}
      ],
      "szimuláció": "a Python 16384·243·25·7 = 696729600 = weylD8·135; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A prím-torony: 2¹⁴ · 3⁵ · 5² · 7", "fájl": "F2.12_1.png"},
        {"cím": "SZÁMOLÁS — A prím-út szorzatlánca", "fájl": "F2.12_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: prím-út ⟷ kernel (Δ = 0)", "fájl": "F2.12_3.png"},
        {"cím": "SPEKTRUM — A Weyl-lánc: 2⁷ → 8! → 135 → W(E8)", "fájl": "F2.12_4.png"},
        {"cím": "HÍD — Híd: struktúra-út W(D8)·135 ⟷ prím-út 2¹⁴·3⁵·5²·7", "fájl": "F2.12_5.png"}
      ],
      "összefoglalóMagyar": "A W(E8) rendjét két fogalmilag különböző konstrukció adja: a csoportszerkezet (W(D8)·135) és a prímfelbontás (2¹⁴·3⁵·5²·7). A kernel mindkettőt ugyanarra a 696 729 600-ra kényszeríti — a tétel-írás kanonikus mintája (AGENTS §18).",
      "összefoglalóKínai": "W(E8) 的阶由两条概念不同的路给出：群结构（W(D8)·135）与质因数分解；内核强制二者同为 696729600——写定理的典范模式。",
      "összefoglalóNémet": "Die Ordnung von W(E8) entsteht auf zwei konzeptuell verschiedenen Wegen: Gruppenstruktur und Primzerlegung; der Kernel zwingt beide auf 696729600 — das kanonische Muster des Theoremschreibens.",
      "összefoglalóHéber": "‏סדר W(E8) ניתן בשני נתיבים מושגית שונים: מבנה החבורה ופירוק ראשוני; הליבה מכריחה את שניהם אל 696729600 — הדגם הקנוני לכתיבת משפטים."
    },
    {
      "azonosító": "F2.13",
      "címMagyar": "Az E8 dimenziója: 240 + 8 = 248 — gyökök + Cartan-algebra",
      "címKínai": "E8 的维数：240 + 8 = 248",
      "címNémet": "Die Dimension von E8: 240 + 8 = 248 — Wurzeln + Cartan-Algebra",
      "címHéber": "‏ממד E8: 240 + 8 = 248",
      "forrásModul": "szima_ter/modul/E8Gyokok_v2.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main",
      "bizonyításTípus": "bizE8Dimenzio : 240 + 8 = 248",
      "kernelSzerepe": "a kernel a gyökök és a Cartan-algebra összegeként normalizálja a 248-at",
      "besorolás": "VALÓDI (gyök + rang)",
      "definíciók": ["public export", "bizE8Dimenzio : 240 + 8 = 248", "bizE8Dimenzio = Refl"],
      "lépések": [
        {"képlet": "240 — a gyökök", "érték": "240", "miért": "minden gyök egy gyökteret feszít ki (F2.05)"},
        {"képlet": "8 — a Cartan-algebra rang", "érték": "8", "miért": "a nyolc diagonális irány — a rang (F2.03: a 8 koordináta)"},
        {"képlet": "240 + 8", "érték": "248", "miért": "a Lie-algebra dimenziója: gyökterek + Cartan"},
        {"képlet": "248 — a legnagyobb kivételes egyszerű Lie-algebra", "érték": "248", "miért": "az E8 ∈ {g2, f4, e6, e7, e8} közül a legnagyobb"}
      ],
      "szimuláció": "a Python len(e8) + 8 = 248; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A 240 gyök 2D-petri-vetülete", "fájl": "F2.13_1.png"},
        {"cím": "SZÁMOLÁS — 240 gyök + 8 Cartan → 248", "fájl": "F2.13_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: dimenzió ⟷ kernel (Δ = 0)", "fájl": "F2.13_3.png"},
        {"cím": "SPEKTRUM — A gyökök eloszlása egy gyök körül: (1, 56, 126, 56, 1)", "fájl": "F2.13_4.png"},
        {"cím": "HÍD — Híd: gyök+Cartan ⟷ kernel bizE8Dimenzio", "fájl": "F2.13_5.png"}
      ],
      "összefoglalóMagyar": "Az E8 Lie-algebra 248 dimenziós: 240 gyökter és a 8 dimenziós Cartan-algebra. Ez a legnagyobb kivételes egyszerű Lie-algebra — a projektstruktúra gerince.",
      "összefoglalóKínai": "E8 李代数为 248 维：240 个根空间与 8 维嘉当代数——最大的例外单李代数。",
      "összefoglalóNémet": "Die E8-Lie-Algebra ist 248-dimensional: 240 Wurzelräume und die 8-dimensionale Cartan-Algebra — die größte Ausnahmealgebra.",
      "összefoglalóHéber": "‏אלגברת לי E8 בת 248 ממדים: 240 מרחבי שורש ואלגברת קרטן בת 8 — האלגברה הפשוטה היוצאת מן הכלל הגדולה ביותר."
    },
    {
      "azonosító": "F2.14",
      "címMagyar": "Keverelt pár: (2,2,0⁶)·(1⁸) = 4 — a 60°-os szög",
      "címKínai": "混合对：(2,2,0⁶)·(1⁸) = 4——60° 角",
      "címNémet": "Gemischtes Paar: (2,2,0⁶)·(1⁸) = 4 — der 60°-Winkel",
      "címHéber": "‏זוג מעורב: (2,2,0⁶)·(1⁸) = 4 — זווית 60°",
      "forrásModul": "szima_ter/modul/E8BelsoSzorzat.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main",
      "bizonyításTípus": "BizSzorzatT1T2 : belsoszorzat (2,2,0⁶) (1⁸) = 4",
      "kernelSzerepe": "a kernel a típus-1 ∩ típus-2 szorzat nyolc tagját adja össze és normalizálja a 4-hez",
      "besorolás": "VALÓDI (tagonkénti összeg ⟷ literál)",
      "definíciók": ["public export", "belsoszorzat : E8Gyok -> E8Gyok -> Integer", "belsoszorzat (E8GyokKonstruktor a1 … a8) (E8GyokKonstruktor b1 … b8)", "  = a1*b1 + a2*b2 + … + a8*b8"],
      "lépések": [
        {"képlet": "a tagok: 2·1 + 2·1 + 0·1·6", "érték": "4", "miért": "csak a két nemnulla koordináta járul hozzá: 2 + 2"},
        {"képlet": "⟨α,β⟩ = 4 a 2-szeres skálán", "érték": "4", "miért": "a normalizált érték: 4/8 = +½, azaz 60°-os szög (F2.20: az 56 szomszéd egyike)"},
        {"képlet": "értelmezés: SzorosanHasonló (+½)", "érték": "+½ szorosan hasonló (60°)", "miért": "ez a híd a GyökSzó ötszintű skálája felé (bizTávolságKevereltPár, F2.36)"}
      ],
      "szimuláció": "a Python sum(a·b) = 4; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A két gyöktípus halmazai", "fájl": "F2.14_1.png"},
        {"cím": "SZÁMOLÁS — A tagok: 2·1 + 2·1 + 0·6", "fájl": "F2.14_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: kevert pár szorzata ⟷ kernel (Δ = 0)", "fájl": "F2.14_3.png"},
        {"cím": "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)", "fájl": "F2.14_4.png"},
        {"cím": "HÍD — Híd: kernel BizSzorzatT1T2 ⟷ szimuláció", "fájl": "F2.14_5.png"}
      ],
      "összefoglalóMagyar": "A típus-1 és típus-2 gyökök nem merőlegesek egymásra: a (2,2,0⁶)·(1⁸) = 4 a 60°-os szög jele — a két család között VAN kapcsolat, ez a szorosan-hasonló szint.",
      "összefoglalóKínai": "第一类与第二类根并非正交：(2,2,0⁶)·(1⁸) = 4 标志 60° 角——两族之间确有联系，即紧密相似层。",
      "összefoglalóNémet": "Typ-1- und Typ-2-Wurzeln sind nicht orthogonal: (2,2,0⁶)·(1⁸) = 4 markiert den 60°-Winkel — es gibt eine Verbindung zwischen den Familien.",
      "összefoglalóHéber": "‏שורשי טיפוס 1 ו־2 אינם אורתוגונליים: (2,2,0⁶)·(1⁸) = 4 מסמן זווית 60° — יש קשר בין המשפחות."
    },
    {
      "azonosító": "F2.15",
      "címMagyar": "Az ellentett szorzata: α·(−α) = −8 (norma² = 8 ellentettel)",
      "címKínai": "相反根的内积：α·(−α) = −8",
      "címNémet": "Das Produkt mit dem Entgegengesetzten: α·(−α) = −8",
      "címHéber": "‏מכפלה עם ההפוך: α·(−α) = −8",
      "forrásModul": "szima_ter/modul/E8BelsoSzorzat.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main",
      "bizonyításTípus": "BizSzorzatEllentett : belsoszorzat (2,2,0⁶) (−2,−2,0⁶) = -8",
      "kernelSzerepe": "a kernel a nyolc ellentett tagot adja össze: −4 − 4 = −8",
      "besorolás": "VALÓDI (ellentett ⟷ −norma²)",
      "definíciók": ["public export", "gyokEllentett : E8Gyok -> E8Gyok", "gyokEllentett = gyokSkalar (-1)", "BizSzorzatEllentett : belsoszorzat (2,2,0⁶) (-2,-2,0⁶) = -8"],
      "lépések": [
        {"képlet": "(−2)·2 + (−2)·2 + 0·6", "érték": "-8", "miért": "minden tag előjeles négyzet: −4 − 4"},
        {"képlet": "⟨α,−α⟩ = −⟨α,α⟩ = −8", "érték": "-8", "miért": "a norma ellentettje — a 180°-os szög (Ellentett szint)"},
        {"képlet": "konklúzió: minden gyök párja a −α", "érték": "1 gyök = −8 az eloszlásban", "miért": "ezért pontosan EGY ellentett van gyökenként (F2.20: az (1,56,126,56,1) első oszlopa)"}
      ],
      "szimuláció": "a Python sum(a·b) a −α-n: −8; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A 240 gyök petri-vetülete (α és −α átellenesen)", "fájl": "F2.15_1.png"},
        {"cím": "SZÁMOLÁS — −4 − 4 → −8", "fájl": "F2.15_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: ellentett-szorzat ⟷ kernel (Δ = 0)", "fájl": "F2.15_3.png"},
        {"cím": "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)", "fájl": "F2.15_4.png"},
        {"cím": "HÍD — Híd: kernel BizSzorzatEllentett ⟷ szimuláció", "fájl": "F2.15_5.png"}
      ],
      "összefoglalóMagyar": "A gyökrendszer centrális szimmetriájú: minden gyök ellentettje is gyök. A ⟨α,−α⟩ = −8 a táblázat minimuma — az Ellentett jelentésszint forrása.",
      "összefoglalóKínai": "根系中心对称：每个根的相反也是根；⟨α,−α⟩ = −8 是表格最小值——相反意义层的来源。",
      "összefoglalóNémet": "Das Wurzelsystem ist zentralsymmetrisch: das Negative jeder Wurzel ist Wurzel; ⟨α,−α⟩ = −8 ist das Tabellenminimum.",
      "összefoglalóHéber": "‏מערכת השורשים מרכזית־סימטרית: שלילת כל שורש היא שורש; ⟨α,−α⟩ = −8 הוא מינימום הטבלה."
    },
    {
      "azonosító": "F2.16",
      "címMagyar": "Merőleges pár: (2,2,0⁶)·(2,−2,0⁶) = 0",
      "címKínai": "正交对：(2,2,0⁶)·(2,−2,0⁶) = 0",
      "címNémet": "Orthogonales Paar: (2,2,0⁶)·(2,−2,0⁶) = 0",
      "címHéber": "‏זוג ניצב: (2,2,0⁶)·(2,−2,0⁶) = 0",
      "forrásModul": "szima_ter/modul/E8BelsoSzorzat.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main",
      "bizonyításTípus": "BizSzorzatMeroleges : belsoszorzat (2,2,0⁶) (2,-2,0⁶) = 0",
      "kernelSzerepe": "a kernel a nyolc tagot adja össze: 4 − 4 = 0",
      "besorolás": "VALÓDI (tagösszeg ⟷ 0 literál)",
      "definíciók": ["public export", "BizSzorzatMeroleges : belsoszorzat (2,2,0⁶) (2,-2,0⁶) = 0", "BizSzorzatMeroleges = Refl"],
      "lépések": [
        {"képlet": "2·2 + 2·(−2) + 0·6", "érték": "0", "miért": "4 − 4 = 0 — a tagok kioltják egymást"},
        {"képlet": "⟨α,β⟩ = 0 → 90°", "érték": "90°-os szög", "miért": "a Semleges jelentésszint forrása (bizTávolságMerőleges)"},
        {"képlet": "az eloszlásban: 126 gyök", "érték": "126 merőleges gyök", "miért": "a legtöbb pár merőleges (F2.20: a 126-os oszlop)"}
      ],
      "szimuláció": "a Python sum(a·b) = 0; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A merőleges vektorok az (x₁,x₂)-síkban", "fájl": "F2.16_1.png"},
        {"cím": "SZÁMOLÁS — 4 − 4 → 0", "fájl": "F2.16_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: merőleges szorzat ⟷ kernel (Δ = 0)", "fájl": "F2.16_3.png"},
        {"cím": "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)", "fájl": "F2.16_4.png"},
        {"cím": "HÍD — Híd: kernel BizSzorzatMeroleges ⟷ szimuláció", "fájl": "F2.16_5.png"}
      ],
      "összefoglalóMagyar": "A 240 gyök többsége merőleges egymásra: a 0 a tábla közepe. A merőlegesség a semleges jelentés forrása — a független fogalmak geometriája.",
      "összefoglalóKínai": "240 个根大多互相正交：0 是表格中心；正交性是中性意义的来源——独立概念的几何。",
      "összefoglalóNémet": "Die meisten der 240 Wurzeln sind orthogonal: 0 ist die Tabellenmitte — die Quelle neutraler Bedeutung.",
      "összefoglalóHéber": "‏רוב 240 השורשים ניצבים זה לזה: 0 הוא מרכז הטבלה — מקור המשמעות הנייטרלית."
    },
    {
      "azonosító": "F2.17",
      "címMagyar": "A tükrözés önmagán: σ_α(α) = −α",
      "címKínai": "反射作用于自身：σ_α(α) = −α",
      "címNémet": "Die Spiegelung auf sich selbst: σ_α(α) = −α",
      "címHéber": "‏השתקפות על עצמו: σ_α(α) = −α",
      "forrásModul": "szima_ter/modul/E8BelsoSzorzat.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main",
      "bizonyításTípus": "BizReflexioOnmagara : weylReflexio (2,2,0⁶) (2,2,0⁶) = (-2,-2,0⁶)",
      "kernelSzerepe": "a kernel a σ_α(α) = α − (8/4)·α = α − 2α = −α számítást normalizálja",
      "besorolás": "VALÓDI (képlet-alkalmazás ⟷ konstruktor)",
      "definíciók": ["public export", "weylReflexio : E8Gyok -> E8Gyok -> E8Gyok", "weylReflexio alfa beta =", "  gyokKulonbseg beta (gyokSkalar (div (belsoszorzat alfa beta) 4) alfa)"],
      "lépések": [
        {"képlet": "⟨α,α⟩ = 8", "érték": "8", "miért": "a norma a 2-szeres skálán (F2.07)"},
        {"képlet": "8 / 4 = 2", "érték": "2", "miért": "egész osztás — nincs törtszám"},
        {"képlet": "σ_α(α) = α − 2·α = −α", "érték": "[-2,-2,0,0,0,0,0,0]", "miért": "a kernel az eredményt konstruktor-egyenlőségre normalizálja: (−2,−2,0,0,0,0,0,0)"}
      ],
      "szimuláció": "a Python tükröz(α, α) az újjáépített gyökrendszeren: (−2,−2,0,0,0,0,0,0); a kernel-szöveggel egyezik",
      "grafikonok": [
        {"cím": "SZERKEZET — A tükrözés vektor-ábrája: α → −α", "fájl": "F2.17_1.png"},
        {"cím": "SZÁMOLÁS — ⟨α,α⟩/4 = 2 → α − 2α", "fájl": "F2.17_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: σ(α,α) szöveg ⟷ kernel (0 = egyezik)", "fájl": "F2.17_3.png"},
        {"cím": "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)", "fájl": "F2.17_4.png"},
        {"cím": "HÍD — Híd: kernel BizReflexioOnmagara ⟷ szimuláció", "fájl": "F2.17_5.png"}
      ],
      "összefoglalóMagyar": "A Weyl-tükrözés a gyök saját tükörsíkján megszűnteti a gyököt és előhozza az ellentettjét: σ_α(α) = −α. Az egész osztás (⟨α,β⟩/4) a simply-laced szerkezet ajándéka.",
      "összefoglalóKínai": "外尔反射把根变为其相反：σ_α(α) = −α；整除（⟨α,β⟩/4）是单连结构的馈赠。",
      "összefoglalóNémet": "Die Weyl-Spiegelung kehrt die Wurzel um: σ_α(α) = −α; die Ganzzahldivision ist das Geschenk der simply-laced-Struktur.",
      "összefoglalóHéber": "‏השתקפות וייל הופכת את השורש להפוכו: σ_α(α) = −α; החילוק השלם הוא מתנת המבנה הפשוט."
    },
    {
      "azonosító": "F2.18",
      "címMagyar": "Merőleges tükrözés: σ_α(β) = β, ha ⟨α,β⟩ = 0",
      "címKínai": "正交反射：若 ⟨α,β⟩ = 0，则 σ_α(β) = β",
      "címNémet": "Orthogonale Spiegelung: σ_α(β) = β, wenn ⟨α,β⟩ = 0",
      "címHéber": "‏השתקפות ניצבת: אם ⟨α,β⟩ = 0 אז σ_α(β) = β",
      "forrásModul": "szima_ter/modul/E8BelsoSzorzat.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main",
      "bizonyításTípus": "BizReflexioMeroleges : weylReflexio (2,2,0⁶) (2,-2,0⁶) = (2,-2,0⁶)",
      "kernelSzerepe": "a kernel a σ_α(β) = β − (0/4)·α = β − 0 számítást normalizálja: a merőleges gyök rögzített",
      "besorolás": "VALÓDI (képlet-alkalmazás ⟷ konstruktor)",
      "definíciók": ["public export", "BizReflexioMeroleges : weylReflexio (2,2,0⁶) (2,-2,0⁶) = (2,-2,0⁶)", "BizReflexioMeroleges = Refl"],
      "lépések": [
        {"képlet": "⟨α,β⊥⟩ = 0", "érték": "0", "miért": "a merőleges szorzat (F2.16)"},
        {"képlet": "0 / 4 = 0", "érték": "0", "miért": "nincs elmozdulás"},
        {"képlet": "σ_α(β⊥) = β⊥ − 0·α = β⊥", "érték": "[2,-2,0,0,0,0,0,0]", "miért": "a tükör síkján fekvő gyök NEM mozdul — a kernel konstruktor-egyenlőséget normalizál"}
      ],
      "szimuláció": "a Python tükröz(α, β⊥) = (2,−2,0,0,0,0,0,0); egyezik a kernel-szöveggel",
      "grafikonok": [
        {"cím": "SZERKEZET — A merőleges β⊥ a tükör síkján marad", "fájl": "F2.18_1.png"},
        {"cím": "SZÁMOLÁS — ⟨α,β⊥⟩/4 = 0 → β − 0·α", "fájl": "F2.18_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: σ(α,β⊥) ⟷ kernel (0 = egyezik)", "fájl": "F2.18_3.png"},
        {"cím": "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)", "fájl": "F2.18_4.png"},
        {"cím": "HÍD — Híd: kernel BizReflexioMeroleges ⟷ szimuláció", "fájl": "F2.18_5.png"}
      ],
      "összefoglalóMagyar": "A tükör síkján fekvő gyökök invariánsak: a 126 merőleges gyök mindegyike rögzített a tükrözés alatt. Ez a szimmetria rögzített-pontja — a fogalmi függetlenség algebrai oka.",
      "összefoglalóKínai": "位于镜面上的根在反射下不变：126 个正交根皆为不动点——概念独立的代数根源。",
      "összefoglalóNémet": "Wurzeln in der Spiegelebene bleiben fix: alle 126 orthogonalen Wurzeln sind Fixpunkte — der algebraische Grund begrifflicher Unabhängigkeit.",
      "összefoglalóHéber": "‏שורשים במישור המראה נשארים קבועים: כל 126 השורשים הניצבים הם נקודות שבת — הסיבה האלגברית לעצמאות מושגית."
    },
    {
      "azonosító": "F2.19",
      "címMagyar": "Szomszéd tükrözése: σ_α(β) = (0,−2,2,0⁵), ha ⟨α,β⟩ = 4",
      "címKínai": "相邻根的反射：σ_α(β) = (0,−2,2,0⁵)",
      "címNémet": "Spiegelung einer Nachbarnwurzel: σ_α(β) = (0,−2,2,0⁵)",
      "címHéber": "‏השתקפות שכן: σ_α(β) = (0,−2,2,0⁵)",
      "forrásModul": "szima_ter/modul/E8BelsoSzorzat.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main",
      "bizonyításTípus": "BizReflexioSzomszed : weylReflexio (2,2,0⁶) (2,0,2,0⁵) = (0,-2,2,0⁵)",
      "kernelSzerepe": "a kernel a σ_α(β) = β − (4/4)·α = β − α számítást normalizálja: az eredmény GYÖK marad",
      "besorolás": "VALÓDI (képlet-alkalmazás ⟷ konstruktor) — a zártság magja",
      "definíciók": ["public export", "BizReflexioSzomszed : weylReflexio (2,2,0⁶) (2,0,2,0⁵) = (0,-2,2,0⁵)", "BizReflexioSzomszed = Refl"],
      "lépések": [
        {"képlet": "⟨α,β⟩ = 4", "érték": "4", "miért": "a 60°-os szomszéd (F2.14)"},
        {"képlet": "4 / 4 = 1", "érték": "1", "miért": "egyszer hozzáadás"},
        {"képlet": "σ_α(β) = β − α = (0,−2,2,0,0,0,0,0)", "érték": "[0,-2,2,0,0,0,0,0]", "miért": "a tükörrel szemben a szomszéd — az eredmény a 240 gyök egyike (zártság!)"}
      ],
      "szimuláció": "a Python tükröz(α, β) = (0,−2,2,0,0,0,0,0); a teljes 57 600 páros zártság a F2.21 kártyán",
      "grafikonok": [
        {"cím": "SZERKEZET — A tükrözés vektor-ábrája: β → β − α", "fájl": "F2.19_1.png"},
        {"cím": "SZÁMOLÁS — ⟨α,β⟩/4 = 1 → β − α", "fájl": "F2.19_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: σ(α,β) ⟷ kernel (0 = egyezik)", "fájl": "F2.19_3.png"},
        {"cím": "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)", "fájl": "F2.19_4.png"},
        {"cím": "HÍD — Híd: kernel BizReflexioSzomszed ⟷ szimuláció", "fájl": "F2.19_5.png"}
      ],
      "összefoglalóMagyar": "A tükrözés a szomszédot a tükör túloldalára viszi — és az eredmény GYÖK marad. Ez az egyetlen példa a zártság magva: a teljes 57 600 páros kimerítés a F2.21-en.",
      "összefoglalóKínai": "反射把邻居送到镜面另一侧，而结果仍是根——封闭性的种子；完整的 57600 对穷举在 F2.21。",
      "összefoglalóNémet": "Die Spiegelung trägt die Nachbarnwurzel auf die andere Seite — das Resultat bleibt Wurzel: der Kern der Abgeschlossenheit; die volle Prüfung auf F2.21.",
      "összefoglalóHéber": "‏ההשתקפות מעבירה את השכן לעבר השני של המראה — והתוצאה נשארת שורש: גרעין הסגירות; הבדיקה המלאה ב־F2.21."
    },
    {
      "azonosító": "F2.20",
      "címMagyar": "Az eloszlás: minden gyökre (1, 56, 126, 56, 1) — futásidejű kimerítés",
      "címKínai": "分布：每个根皆为 (1, 56, 126, 56, 1)——运行时穷举",
      "címNémet": "Die Verteilung: für jede Wurzel (1, 56, 126, 56, 1) — Laufzeit-Erschöpfung",
      "címHéber": "‏ההתפלגות: לכל שורש (1, 56, 126, 56, 1)",
      "forrásModul": "szima_ter/modul/E8BelsoSzorzat.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main",
      "bizonyításTípus": "eloszlasHibakSzama : Nat (futásidőben 0) — eloszlas alfa = (1, 56, 126, 56, 1)",
      "kernelSzerepe": "a kernel nem bizonyítja Refl-lel a 240 eloszlást (az 240×240 kimerítés túlságosan nagy a normalizálónak) — a FUTÁSIDŐŰ KIMERÍTÉS a fedés: minden gyökre kiszámolja az eloszlást és összeveti a várttal",
      "besorolás": "FUTÁSIDŐŰ KIMERÍTÉS (240 gyök × 240 gyök)",
      "definíciók": ["public export", "eloszlas : E8Gyok -> (Nat, Nat, Nat, Nat, Nat)", "eloszlas alfa = ( darab (-8), darab (-4), darab 0, darab 4, darab 8 )", "eloszlasHibakSzama : Nat", "eloszlasHibakSzama =", "  length (filter (\a => eloszlas a /= (1, 56, 126, 56, 1)) e8Gyokok)"],
      "lépések": [
        {"képlet": "a példagyök (2,2,0⁶) eloszlása", "érték": "(1, (56, (126, (56, 1))))", "miért": "futásidőben mérve: 1 ellentett, 56×120°-os, 126 merőleges, 56×60°-os, 1 önmaga"},
        {"képlet": "hibás eloszlású gyökök száma", "érték": "0", "miért": "mind a 240 gyökön kimerítve — várt érték 0"},
        {"képlet": "ellenőrzés: 1+56+126+56+1", "érték": "240", "miért": "az eloszlás összege 240 — minden gyök pontosan osztályozva"}
      ],
      "szimuláció": "a Python a 240×240 mátrixon megszámolja mind az öt érték oszlopait: páronként 240, 13440, 30240, 13440, 240 (össz 57600); a rosszEloszlás száma 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A 240×240 belsőszorzat-mátrix hőképe", "fájl": "F2.20_1.png"},
        {"cím": "SZÁMOLÁS — A példagyök eloszlása: (1, 56, 126, 56, 1)", "fájl": "F2.20_2.png"},
        {"cím": "ELLENŐRZÉS — Rossz eloszlású gyökök száma (várható 0)", "fájl": "F2.20_3.png"},
        {"cím": "SPEKTRUM — A pár-számok: 240, 13440, 30240, 13440, 240", "fájl": "F2.20_4.png"},
        {"cím": "HÍD — Híd: kernel eloszlasHibakSzama ⟷ szimuláció rosszEloszlás", "fájl": "F2.20_5.png"}
      ],
      "összefoglalóMagyar": "A belső szorzat értékei csak ötfélék {−8,−4,0,+4,+8}, és minden gyök körül pontosan ugyanaz a zenéjű eloszlás áll: 1, 56, 126, 56, 1. Ez a krisztalografikus kvantálás numerikus arca (Conway–Sloane, SPLAG 8. fejezet).",
      "összefoglalóKínai": "内积只取五个值 {−8,−4,0,+4,+8}，且每个根周围的分布都是 1, 56, 126, 56, 1——晶体学量子化的数值面貌。",
      "összefoglalóNémet": "Die Innerprodukte nehmen nur fünf Werte an, und um jede Wurzel steht dieselbe Verteilung 1, 56, 126, 56, 1 — das numerische Gesicht der kristallographischen Quantelung.",
      "összefoglalóHéber": "‏המכפלות הפנימיות נוטלות חמישה ערכים בלבד, וסביב כל שורש אותה התפלגות 1, 56, 126, 56, 1 — פניו המספריים של הקוונטום הגבישי."
    },
    {
      "azonosító": "F2.21",
      "címMagyar": "A Weyl-zártság: mind az 57 600 tükrözés gyököt ad — futásidejű kimerítés",
      "címKínai": "外尔封闭性：57600 次反射全给出根——运行时穷举",
      "címNémet": "Die Weyl-Abgeschlossenheit: alle 57600 Spiegelungen ergeben Wurzeln",
      "címHéber": "‏סגירות וייל: כל 57600 ההשתקפויות נותנות שורש",
      "forrásModul": "szima_ter/modul/E8BelsoSzorzat.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main",
      "bizonyításTípus": "zarasHibakSzama : Nat (futásidőben 0)",
      "kernelSzerepe": "a kernel Refl-lel csak konkrét párokat bizonyít (F2.17–19); a TELJES zártság 240×240 = 57 600 páros futásidejű kimerítéssel federett: minden σ_α(β) benne van a 240-ban",
      "besorolás": "FUTÁSIDŐŰ KIMERÍTÉS (57 600 pár)",
      "definíciók": ["public export", "zar : E8Gyok -> E8Gyok -> Bool", "zar alfa beta = benVan (weylReflexio alfa beta) e8Gyokok", "zarasHibakSzama : Nat", "zarasHibakSzama = length (filter not [ zar alfa beta | alfa <- e8Gyokok, beta <- e8Gyokok ])"],
      "lépések": [
        {"képlet": "a párok száma: 240 · 240", "érték": "57600", "miért": "minden (α, β) párra kiszámoljuk σ_α(β)-t"},
        {"képlet": "nem-gyök reflexiók száma", "érték": "0", "miért": "futásidőben mérve — várt érték 0"},
        {"képlet": "következmény: a tükrözések generálják W(E8)-t", "érték": "696729600", "miért": "a zártság miatt a tükrözések csoportot alkotnak — rendje 696 729 600 (F2.11–12)"}
      ],
      "szimuláció": "a Python halmaz-tagsággal (set) ellenőrzi mind az 57 600 tükrözést: zárásHibák = 0; a mátrix-hőképen a {−8,−4,0,+4,+8} rácsos mintázat látszik",
      "grafikonok": [
        {"cím": "SZERKEZET — A 240×240 belsőszorzat-mátrix hőképe", "fájl": "F2.21_1.png"},
        {"cím": "SZÁMOLÁS — 240·240 pár → 0 hibás tükrözés", "fájl": "F2.21_2.png"},
        {"cím": "ELLENŐRZÉS — ZárásHibák ⟷ kernel zarasHibakSzama (0 = 0)", "fájl": "F2.21_3.png"},
        {"cím": "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)", "fájl": "F2.21_4.png"},
        {"cím": "HÍD — Híd: kernel zarasHibakSzama ⟷ szimuláció zárásHibák", "fájl": "F2.21_5.png"}
      ],
      "összefoglalóMagyar": "A tükrözések nem vezetnek ki a gyökrendszerből: mind az 57 600 reflexió-pár eredménye gyök. Ez a zártság teszi a tükrözéseket csoporttá — a W(E8) létezésének numerikus bizonyítéka.",
      "összefoglalóKínai": "反射不会走出根系：全部 57600 对的结果都是根——正是封闭性使反射成群，即 W(E8) 存在的数值证明。",
      "összefoglalóNémet": "Die Spiegelungen verlassen das Wurzelsystem nicht: alle 57600 Paare ergeben Wurzeln — die Abgeschlossenheit macht die Spiegelungen zur Gruppe, der numerische Beweis der Existenz von W(E8).",
      "összefoglalóHéber": "‏ההשתקפויות אינן יוצאות ממערכת השורשים: כל 57600 הזוגות נותנים שורשים — הסגירות הופכת את ההשתקפויות לחבורה, ההוכחה המספרית לקיום W(E8)."
    },
    {
      "azonosító": "F2.22",
      "címMagyar": "A típus-összeg híd: 112 + 128 = 240 (iránymutató-modul)",
      "címKínai": "类型之和桥：112 + 128 = 240（指针模块）",
      "címNémet": "Die Typensummen-Brücke: 112 + 128 = 240 (Kompassmodul)",
      "címHéber": "‏גשר סכום הטיפוסים: 112 + 128 = 240",
      "forrásModul": "szima_ter/modul/E8Iranymutato_v1.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Iranymutato_v1.idr --exec main",
      "bizonyításTípus": "TipusOsszegBizonyit : 112 + 128 = 240",
      "kernelSzerepe": "a kernel az összeg-típust normalizálja; a modul futásidejű számlálóval (gyokSzamSzamitott) is méri a 240-et — MINDEN IMPORTÁLVA (§24), semmi nincs újraírva",
      "besorolás": "KÉT ÚT (Refl-összeg ⟷ futásidejű számláló)",
      "definíciók": ["public export", "gyokSzamSzamitott : Integer", "gyokSzamSzamitott = cast (List.length e8Gyokok)", "TipusOsszegBizonyit : 112 + 128 = 240", "TipusOsszegBizonyit = Refl"],
      "lépések": [
        {"képlet": "112 (típus-1) + 128 (típus-2)", "érték": "240", "miért": "a két típus futásidőben mért hossza"},
        {"képlet": "gyokSzamSzamitott = cast (length e8Gyokok)", "érték": "240", "miért": "a teljes lista hossza Integer-re öntve — a modul saját futásidejű ellenőrzése"},
        {"képlet": "TipusOsszegBizonyit : 112 + 128 = 240", "érték": "240", "miért": "a kernel-tétel — a kártyázás célja, hogy a kettő ugyanaz a szám legyen"}
      ],
      "szimuláció": "a Python len(e8) = 240 és 112+128 = 240; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A 240 gyök 2D-petri-vetülete", "fájl": "F2.22_1.png"},
        {"cím": "SZÁMOLÁS — 112 + 128 → 240", "fájl": "F2.22_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: gyökSzám ⟷ kernel (Δ = 0)", "fájl": "F2.22_3.png"},
        {"cím": "SPEKTRUM — norma²-hisztogram mind a 240 gyökön", "fájl": "F2.22_4.png"},
        {"cím": "HÍD — Híd: Refl-összeg ⟷ futásidejű számláló", "fájl": "F2.22_5.png"}
      ],
      "összefoglalóMagyar": "Az iránymutató-modul mintája: semmit nem ír újra, importálja a gyöklistát, és a kernel-tételt futásidejű számlálóval fedi. Ez a §24 mintakártyája.",
      "összefoglalóKínai": "指针模块的范式：一切导入、零重写，用运行时计数器覆盖内核定理——§24 的范例卡。",
      "összefoglalóNémet": "Das Kompassmodul als Muster: alles importiert, nichts neu geschrieben; der Kern-Satz wird durch einen Laufzeitzähler gedeckt — die §24-Musterkarte.",
      "összefoglalóHéber": "‏מודול המצפן כדפוס: הכול מיובא, כלום לא נכתב מחדש; משפט הליבה מכוסה במונה בזמן־ריצה — כרטיס המופת של §24."
    },
    {
      "azonosító": "F2.23",
      "címMagyar": "A felezett út: 2 · 348 364 800 = 696 729 600",
      "címKínai": "折半之路：2 · 348364800 = 696729600",
      "címNémet": "Der halbierte Weg: 2 · 348364800 = 696729600",
      "címHéber": "‏דרך החצייה: 2 · 348364800 = 696729600",
      "forrásModul": "szima_ter/modul/E8Iranymutato_v1.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Iranymutato_v1.idr --exec main",
      "bizonyításTípus": "WeylRendFelezettBizonyit : 2 * 348364800 = 696729600",
      "kernelSzerepe": "a kernel a felezett rend megkettőzését normalizálja (Conway–Sloane, SPLAG)",
      "besorolás": "KÉT ÚT (felezett × 2 ⟷ teljes rend)",
      "definíciók": ["public export", "WeylRendFelezettBizonyit : 2 * 348364800 = 696729600", "WeylRendFelezettBizonyit = Refl"],
      "lépések": [
        {"képlet": "W(E8) fele", "érték": "348364800", "miért": "a csoport fele (a lehetséges felezések egyike)"},
        {"képlet": "2 · 348 364 800", "érték": "696729600", "miért": "megkettőzve"},
        {"képlet": "ellenőrzés a struktúra-úttal", "érték": "696729600", "miért": "W(D8)·135 = 696 729 600 (F2.11) — a felezett út ugyanoda ér"}
      ],
      "szimuláció": "a Python 2·348364800 = 696729600 = weylD8·trialitás; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A Weyl-lánc: 2⁷ → 8! → 135 → W(E8)", "fájl": "F2.23_1.png"},
        {"cím": "SZÁMOLÁS — A felezett rend megkettőzése", "fájl": "F2.23_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: felezett út ⟷ kernel (Δ = 0)", "fájl": "F2.23_3.png"},
        {"cím": "SPEKTRUM — A prímtornyok: 2¹⁴, 3⁵, 5², 7", "fájl": "F2.23_4.png"},
        {"cím": "HÍD — Híd: 2·348364800 ⟷ kernel W(E8)", "fájl": "F2.23_5.png"}
      ],
      "összefoglalóMagyar": "A W(E8) rendje felezhető úton is előáll: 2 · 348 364 800. A különös felezés a SPLAG-hivatkozás nyomán él a modulban — harmadik független út a 696 729 600-hoz.",
      "összefoglalóKínai": "W(E8) 的阶也可由折半路得出：2 · 348364800——通往 696729600 的第三条独立路。",
      "összefoglalóNémet": "Die Ordnung von W(E8) auch auf dem halbierten Weg: 2 · 348364800 — ein dritter unabhängiger Weg zu 696729600.",
      "összefoglalóHéber": "‏סדר W(E8) גם בדרך החצייה: 2 · 348364800 — נתיב שלישי ועצמאי אל 696729600."
    },
    {
      "azonosító": "F2.24",
      "címMagyar": "A prímtényezős út: 16384·243·25·7 = 696 729 600 (iránymutató)",
      "címKínai": "质因数之路：16384·243·25·7 = 696729600",
      "címNémet": "Der Primfaktorenweg: 16384·243·25·7 = 696729600",
      "címHéber": "‏דרך הגורמים הראשוניים: 16384·243·25·7",
      "forrásModul": "szima_ter/modul/E8Iranymutato_v1.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Iranymutato_v1.idr --exec main",
      "bizonyításTípus": "WeylRendPrimtenyezosBizonyit : 16384 * 243 * 25 * 7 = 696729600",
      "kernelSzerepe": "a kernel a prímtényezős szorzatot normalizálja ugyanahhoz a rendhez — az E8Gyokok_v2 bizWeylE8Prím-jének importált ikertestvére",
      "besorolás": "KÉT ÚT-HÍD (struktúra ⟷ prímek — az iránymutató modulban)",
      "definíciók": ["public export", "WeylRendPrimtenyezosBizonyit : 16384 * 243 * 25 * 7 = 696729600", "WeylRendPrimtenyezosBizonyit = Refl"],
      "lépések": [
        {"képlet": "2¹⁴ · 3⁵ · 5² · 7", "érték": "696729600", "miért": "a prímfelbontás"},
        {"képlet": "W(D8) · 135", "érték": "696729600", "miért": "a struktúra-út (F2.11)"},
        {"képlet": "Δ a két út közt", "érték": "0", "miért": "a két fogalmilag különböző konstrukció maradéka: nulla"}
      ],
      "szimuláció": "a Python prímÚtWeyl = weylE8 = 696729600; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A prím-torony: 2¹⁴ · 3⁵ · 5² · 7", "fájl": "F2.24_1.png"},
        {"cím": "SZÁMOLÁS — A prím-út szorzata", "fájl": "F2.24_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: prím-út ⟷ kernel (Δ = 0)", "fájl": "F2.24_3.png"},
        {"cím": "SPEKTRUM — A Weyl-lánc: 2⁷ → 8! → 135 → W(E8)", "fájl": "F2.24_4.png"},
        {"cím": "HÍD — Híd: prím-út ⟷ struktúra-út", "fájl": "F2.24_5.png"}
      ],
      "összefoglalóMagyar": "Ugyanaz a két-út-híd, mint F2.12 — de az iránymutató-modul saját Refl-jével: a modulok egymás tényeit importálva fedik, nem másolva (§24).",
      "összefoglalóKínai": "与 F2.12 相同的两路桥，但由指针模块自己的 Refl 覆盖：模块通过导入而非复制来相互印证（§24）。",
      "összefoglalóNémet": "Dieselbe Zwei-Wege-Brücke wie F2.12, doch mit dem eigenen Refl des Kompassmoduls: Module decken einander durch Import, nicht durch Kopie.",
      "összefoglalóHéber": "‏אותו גשר כמו F2.12, אך עם ה־Refl של מודול המצפן: מודולים מכסים זה את זה בייבוא, לא בהעתקה."
    },
    {
      "azonosító": "F2.25",
      "címMagyar": "E8 × E8 = 496 — a heterotikus string dimenziója",
      "címKínai": "E8 × E8 = 496——杂弦维度",
      "címNémet": "E8 × E8 = 496 — die Dimension der heterotischen Stringtheorie",
      "címHéber": "‏E8 × E8 = 496 — ממד המיתר ההטרוטי",
      "forrásModul": "szima_ter/modul/E8Iranymutato_v1.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Iranymutato_v1.idr --exec main",
      "bizonyításTípus": "E8E8DimenzioBizonyit : 248 * 2 = 496",
      "kernelSzerepe": "a kernel a két 248-as Lie-algebra szorzatát normalizálja: a bal E8 a tér, a jobb E8 a szín (AGENTS §7)",
      "besorolás": "KÉT ÚT (dimenzió-szorzat ⟷ fizikai értelmezés)",
      "definíciók": ["public export", "e8E8Dimenzio : Integer   -- 496", "E8E8DimenzioBizonyit : 248 * 2 = 496", "E8E8DimenzioBizonyit = Refl"],
      "lépések": [
        {"képlet": "248 (E8 dimenzió, F2.13)", "érték": "248", "miért": "gyökök + Cartan"},
        {"képlet": "248 · 2", "érték": "496", "miért": "két E8: bal (tér) és jobb (szín)"},
        {"képlet": "496 — a heterotikus string", "érték": "496", "miért": "a gauge-csoport E8×E8 esetén a bozonok 496 szabadságfokon élnek — ez a projekt fizikai horgonya"}
      ],
      "szimuláció": "a Python 248·2 = 496; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — Két E8: bal (tér) × jobb (szín)", "fájl": "F2.25_1.png"},
        {"cím": "SZÁMOLÁS — 248 · 2 → 496", "fájl": "F2.25_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: 496 ⟷ kernel (Δ = 0)", "fájl": "F2.25_3.png"},
        {"cím": "SPEKTRUM — A 240 gyök petri-vetülete", "fájl": "F2.25_4.png"},
        {"cím": "HÍD — Híd: dimenzió-szorzat ⟷ kernel 496", "fájl": "F2.25_5.png"}
      ],
      "összefoglalóMagyar": "A 496 a heterotikus string dimenziója: a bal E8 a tér, a jobb E8 a szín oldala. A projekt központi fizikai sejtése ebből a számból nő ki (AGENTS §7).",
      "összefoglalóKínai": "496 是杂弦维度：左 E8 主空间，右 E8 主颜色——项目核心物理猜想由此而生（AGENTS §7）。",
      "összefoglalóNémet": "496 ist die Dimension der heterotischen Stringtheorie: links E8 der Raum, rechts E8 die Farbe — die zentrale physikalische Vermutung des Projekts.",
      "összefoglalóHéber": "‏496 הוא ממד המיתר ההטרוטי: שמאל E8 המרחב, ימין E8 הצבע — משם צומחת ההשערה הפיזיקלית המרכזית."
    },
    {
      "azonosító": "F2.26",
      "címMagyar": "A gyökök felezése: 240 = 2 · 120 — a pozitív/negatív ábécé",
      "címKínai": "根的对分：240 = 2·120——正负字母表",
      "címNémet": "Die Halbierung der Wurzeln: 240 = 2 · 120 — das positive/negative Alphabet",
      "címHéber": "‏חלוקת השורשים: 240 = 2·120",
      "forrásModul": "szima_ter/modul/E8Iranymutato_v1.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8Iranymutato_v1.idr --exec main",
      "bizonyításTípus": "GyokFelezingBizonyit : 240 = 2 * 120",
      "kernelSzerepe": "a kernel a felezést normalizálja: minden gyök párja az ellentettjével — a pozitív gyökök száma 120",
      "besorolás": "KÉT ÚT (párosítás ⟷ felezés)",
      "definíciók": ["public export", "GyokFelezingBizonyit : 240 = 2 * 120", "GyokFelezingBizonyit = Refl"],
      "lépések": [
        {"képlet": "240 gyök", "érték": "240", "miért": "a teljes rendszer (F2.05)"},
        {"képlet": "α és −α párok", "érték": "120", "miért": "a centrális szimmetria miatt fele-fele (F2.15)"},
        {"képlet": "120 pozitív gyök", "érték": "120", "miért": "a pozitív ábécé — a nyelv építőkőze (E8FazisKapcsolat_v2: pozitivGyokok)"}
      ],
      "szimuláció": "a Python párosítja a gyököket (v, −v): 120 pár; 2·120 = 240; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A 240 gyök 2D-petri-vetülete (α, −α átellenesen)", "fájl": "F2.26_1.png"},
        {"cím": "SZÁMOLÁS — 2 · 120 → 240", "fájl": "F2.26_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: felezés ⟷ enumeráció (Δ = 0)", "fájl": "F2.26_3.png"},
        {"cím": "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)", "fájl": "F2.26_4.png"},
        {"cím": "HÍD — Híd: 2·120 ⟷ enumeráció 240", "fájl": "F2.26_5.png"}
      ],
      "összefoglalóMagyar": "A 240 gyök 120 ±-párba rendezhető: a pozitív fél a szimbólum-ábécé (a nyelvi réteg ezt használja). A felezés a centrális szimmetria közvetlen következménye.",
      "összefoglalóKínai": "240 个根可排成 120 个 ± 对：正半是符号字母表（语言层所用）；对分是中心对称的直接推论。",
      "összefoglalóNémet": "Die 240 Wurzeln bilden 120 ±-Paare: die positive Hälfte ist das Symbolalphabet (die Sprachschicht benutzt es) — die Halbierung folgt direkt aus der Zentralsymmetrie.",
      "összefoglalóHéber": "‏240 השורשים יוצרים 120 זוגות ±: החצי החיובי הוא אלפבית הסמלים — החלוקה נובעת ישירות מהסימטריה המרכזית."
    },
    {
      "azonosító": "F2.27",
      "címMagyar": "A Cl(4) fokszámainak összege: 1+4+6+4+1 = 16 (binomiális tétel)",
      "címKínai": "Cl(4) 各阶之和：1+4+6+4+1 = 16（二项式定理）",
      "címNémet": "Die Summe der Cl(4)-Grade: 1+4+6+4+1 = 16 (Binomialtheorem)",
      "címHéber": "‏סכום דרגות Cl(4): 1+4+6+4+1 = 16",
      "forrásModul": "szima_ter/modul/E8TizenhatPenge.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main",
      "bizonyításTípus": "BizFokszamOsszeg : 1 + 4 + 6 + 4 + 1 = 16",
      "kernelSzerepe": "a kernel az öt binomiális együttható összegét normalizálja a 16-hoz",
      "besorolás": "KÉT ÚT (binomiális összeg ⟷ hatvány — l. F2.28)",
      "definíciók": ["public export", "pengeFok : Integer -> Nat", "fokSzamlalok : (Nat, Nat, Nat, Nat, Nat)", "BizFokszamOsszeg : 1 + 4 + 6 + 4 + 1 = 16", "BizFokszamOsszeg = Refl"],
      "lépések": [
        {"képlet": "C(4,0)=1, C(4,1)=4, C(4,2)=6, C(4,3)=4, C(4,4)=1", "érték": "1, 4, 6, 4, 1", "miért": "a {1,2,3,4} halmaz részhalmazai fokszám szerint — futásidőben a fokSzamlalok méri"},
        {"képlet": "1+4+6+4+1", "érték": "16", "miért": "a binomiális együtthatók összege"},
        {"képlet": "2⁴ = 16", "érték": "16", "miért": "a binomiális tétel: Σ C(4,k) = 2⁴ (a második út — F2.28)"}
      ],
      "szimuláció": "a Python popcount-szal fokszámot számol mind a 16 pengére: (1, 4, 6, 4, 1); az összeg 16; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A Cl(4) fokszámai: (1, 4, 6, 4, 1)", "fájl": "F2.27_1.png"},
        {"cím": "SZÁMOLÁS — C(4,k) oszlopok: 1, 4, 6, 4, 1", "fájl": "F2.27_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: fokszám-összeg ⟷ kernel (Δ = 0)", "fájl": "F2.27_3.png"},
        {"cím": "SPEKTRUM — A Hodge-duál nyilai: k ↔ 4−k", "fájl": "F2.27_4.png"},
        {"cím": "HÍD — Híd: binomiális összeg ⟷ szimuláció", "fájl": "F2.27_5.png"}
      ],
      "összefoglalóMagyar": "A 4 dimenziós Clifford-algebra pengéi a részhalmazok: fokszám szerint 1, 4, 6, 4, 1 — a binomiális tétel élő példája, és a Hamming-súlyeloszlás (1,7,7,1) testvére.",
      "összefoglalóKínai": "四维 Clifford 代数的刃即子集：按阶为 1,4,6,4,1——二项式定理的活例，也是汉明重量分布 (1,7,7,1) 的姊妹。",
      "összefoglalóNémet": "Die Blades der vierdimensionalen Clifford-Algebra sind die Teilmengen: nach Grad 1, 4, 6, 4, 1 — das lebende Binomialtheorem und Schwester der Hamming-Verteilung (1,7,7,1).",
      "összefoglalóHéber": "‏להבי אלגברת קליפורד הארבע־ממדית הם תת־קבוצות: לפי דרגה 1, 4, 6, 4, 1 — משפט הבינום החי, אחותה של התפלגות המינג (1,7,7,1)."
    },
    {
      "azonosító": "F2.28",
      "címMagyar": "A 2⁴ = 16 — a pengék számának hatvány-útja",
      "címKínai": "2⁴ = 16——刃数的幂路",
      "címNémet": "2⁴ = 16 — der Potenzweg der Blade-Anzahl",
      "címHéber": "‏2⁴ = 16 — דרך החזקה של מספר הלהבים",
      "forrásModul": "szima_ter/modul/E8TizenhatPenge.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main",
      "bizonyításTípus": "BizKettoNegyedik : 2 * 2 * 2 * 2 = 16",
      "kernelSzerepe": "a kernel a négy kettes szorzatát normalizálja a 16-hoz",
      "besorolás": "KÉT ÚT (hatvány ⟷ binomiális összeg)",
      "definíciók": ["public export", "BizKettoNegyedik : 2 * 2 * 2 * 2 = 16", "BizKettoNegyedik = Refl"],
      "lépések": [
        {"képlet": "2 · 2 · 2 · 2", "érték": "16", "miért": "négy generátor: mindegyik jelen/nincs"},
        {"képlet": "= 16 penge", "érték": "16", "miért": "ugyanaz, mint 1+4+6+4+1 (F2.27)"},
        {"képlet": "bitmask 0..15", "érték": "15", "miért": "a pengék természetes indexelése: 0000₂ … 1111₂"}
      ],
      "szimuláció": "a Python 2**4 = 16 = len(pengék); Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — 240 gyök + 16 penge egy rácsban", "fájl": "F2.28_1.png"},
        {"cím": "SZÁMOLÁS — A kettő-hatvány létra: 2¹…2⁴", "fájl": "F2.28_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: 2⁴ ⟷ len(pengék) (Δ = 0)", "fájl": "F2.28_3.png"},
        {"cím": "SPEKTRUM — A Cl(4) fokszámai: (1, 4, 6, 4, 1)", "fájl": "F2.28_4.png"},
        {"cím": "HÍD — Híd: 2·2·2·2 ⟷ enumeráció", "fájl": "F2.28_5.png"}
      ],
      "összefoglalóMagyar": "A 16 penge két úton áll elő: négy bit helyeinek hatványaaként és a binomiális együtthatók összegeként. A két út a F2.27-tel közös híd.",
      "összefoglalóKínai": "16 刃由两条路得出：四个比特的幂次与二项式系数之和；两路之桥与 F2.27 共享。",
      "összefoglalóNémet": "Die 16 Blades entstehen auf zwei Wegen: als Potenz von vier Bits und als Summe der Binomialkoeffizienten — die Brücke teilt sich mit F2.27.",
      "összefoglalóHéber": "‏16 הלהבים נובעים בשני נתיבים: חזקה של ארבעה סיביות וסכום מקדמים בינומיים — הגשר משותף עם F2.27."
    },
    {
      "azonosító": "F2.29",
      "címMagyar": "A Hodge-duál példája: duál(e1∧e2) = e3∧e4 (3 → 12)",
      "címKínai": "霍奇对偶例：duál(e1∧e2) = e3∧e4（3 → 12）",
      "címNémet": "Das Hodge-Dual-Beispiel: duál(e1∧e2) = e3∧e4 (3 → 12)",
      "címHéber": "‏דואל הודג' לדוגמה: 3 → 12",
      "forrásModul": "szima_ter/modul/E8TizenhatPenge.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main",
      "bizonyításTípus": "BizHodgePelda : pengeDual 3 = 12",
      "kernelSzerepe": "a kernel a bitkomplemens számítást normalizálja: 0011₂ → 1100₂",
      "besorolás": "VALÓDI (bitkomplemens ⟷ konstruktor)",
      "definíciók": ["public export", "pengeDual : Integer -> Integer", "pengeDual x = 15 - x", "BizHodgePelda : pengeDual 3 = 12", "BizHodgePelda = Refl"],
      "lépések": [
        {"képlet": "3 = 0011₂ = e1∧e2", "érték": "3", "miért": "az első két generátor jelen"},
        {"képlet": "15 − 3 = 12", "érték": "12", "miért": "a bitmask komplemense (nincs átvitel)"},
        {"képlet": "12 = 1100₂ = e3∧e4", "érték": "12", "miért": "a duál bivektor: a hiányzó generátorok éppenessége"}
      ],
      "szimuláció": "a Python duál(3) = 15−3 = 12; fok(3) = fok(12) = 2; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A Hodge-duál nyilai: k ↔ 4−k mind a 16 pengén", "fájl": "F2.29_1.png"},
        {"cím": "SZÁMOLÁS — 15 − 3 → 12", "fájl": "F2.29_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: duál(3) ⟷ kernel (Δ = 0)", "fájl": "F2.29_3.png"},
        {"cím": "SPEKTRUM — A Cl(4) fokszámai: (1, 4, 6, 4, 1)", "fájl": "F2.29_4.png"},
        {"cím": "HÍD — Híd: kernel BizHodgePelda ⟷ szimuláció duál(3)", "fájl": "F2.29_5.png"}
      ],
      "összefoglalóMagyar": "A Hodge-duál a fokot kiegészíti 4-ig: a 2-fokú e1∧e2 duálja a szintén 2-fokú e3∧e4. A bitkomplemens átvitel nélküli — a bitek függetlenek.",
      "összefoglalóKínai": "霍奇对偶把阶补足到 4：2 阶的 e1∧e2 之对偶是同为 2 阶的 e3∧e4；按位取反无进位——比特彼此独立。",
      "összefoglalóNémet": "Das Hodge-Dual ergänzt den Grad bis 4: das Dual des 2-gradigen e1∧e2 ist das ebenfalls 2-gradige e3∧e4; das Bitkomplement ohne Übertrag.",
      "összefoglalóHéber": "‏דואל הודג' משלים את הדרגה עד 4: הדואל של e1∧e2 הוא e3∧e4; השלמת הסיביות בלי נשיאה."
    },
    {
      "azonosító": "F2.30",
      "címMagyar": "A duál involúció: duál(duál(5)) = 5",
      "címKínai": "对合：duál(duál(5)) = 5",
      "címNémet": "Die Dual-Involution: duál(duál(5)) = 5",
      "címHéber": "‏חזרה כפולה: duál(duál(5)) = 5",
      "forrásModul": "szima_ter/modul/E8TizenhatPenge.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main",
      "bizonyításTípus": "BizHodgeInvolutioPelda : pengeDual (pengeDual 5) = 5",
      "kernelSzerepe": "a kernel a kétszeres komplemenst normalizálja az identitásra (0101₂)",
      "besorolás": "VALÓDI (involúció ⟷ konstruktor)",
      "definíciók": ["public export", "BizHodgeInvolutioPelda : pengeDual (pengeDual 5) = 5", "BizHodgeInvolutioPelda = Refl"],
      "lépések": [
        {"képlet": "5 = 0101₂", "érték": "5", "miért": "e1∧e3"},
        {"képlet": "duál(5) = 15 − 5 = 10", "érték": "10", "miért": "1010₂ = e2∧e4"},
        {"képlet": "duál(duál(5)) = 15 − 10 = 5", "érték": "5", "miért": "a kétszeres komplemens visszaadja az eredetit — involúció"}
      ],
      "szimuláció": "a Python mind a 16 pengén ellenőrzi: duál(duál(p)) = p (hibák: 0); fok(duál(p)) + fok(p) = 4 mindig",
      "grafikonok": [
        {"cím": "SZERKEZET — A Hodge-duál nyilai: k ↔ 4−k", "fájl": "F2.30_1.png"},
        {"cím": "SZÁMOLÁS — 5 → 10 → 5 (oda-vissza)", "fájl": "F2.30_2.png"},
        {"cím": "ELLENŐRZÉS — Involúció-hibák a 16 pengén (várható 0)", "fájl": "F2.30_3.png"},
        {"cím": "SPEKTRUM — A Cl(4) fokszámai: (1, 4, 6, 4, 1)", "fájl": "F2.30_4.png"},
        {"cím": "HÍD — Híd: kernel duál(duál(5)) ⟷ szimuláció", "fájl": "F2.30_5.png"}
      ],
      "összefoglalóMagyar": "A Hodge-duál involúció: kétszer alkalmazva az identitás. Ugyanez a szerkezet él a Weyl-tükrözésnél (σ² = id) — a duális szerkezetek közös mintája.",
      "összefoglalóKínai": "霍奇对合：两次作用等于恒等；与外尔反射 σ² = id 同构——对偶结构的共同模式。",
      "összefoglalóNémet": "Das Hodge-Dual ist eine Involution — dasselbe Muster wie die Weyl-Spiegelung σ² = id: das gemeinsame Bild dualer Strukturen.",
      "összefoglalóHéber": "‏דואל הודג' הוא אינבולוציה — אותו מופע כמו השתקפות וייל σ² = id: תבנית משותפת למבנים דואליים."
    },
    {
      "azonosító": "F2.31",
      "címMagyar": "A Hamming-kód első kódszava: [1,0,0,0] → [1,0,0,0,0,1,1]",
      "címKínai": "汉明码首码字：[1,0,0,0] → [1,0,0,0,0,1,1]",
      "címNémet": "Das erste Hamming-Codewort: [1,0,0,0] → [1,0,0,0,0,1,1]",
      "címHéber": "‏מילת הקוד הראשונה: [1,0,0,0] → [1,0,0,0,0,1,1]",
      "forrásModul": "szima_ter/modul/E8TizenhatPenge.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main",
      "bizonyításTípus": "BizKodszoElso : kodszamitas [1,0,0,0] = [1,0,0,0,0,1,1]",
      "kernelSzerepe": "a kernel az m·G mod 2 mátrix-szorzást hét koordinátán normalizálja",
      "besorolás": "VALÓDI (m·G mod 2 ⟷ kódszó)",
      "definíciók": ["public export", "kodszamitas : List Integer -> List Integer", "-- a 7 bit: [idő, okság, tér, szín, hang, fázis, mód]", "BizKodszoElso : kodszamitas [1,0,0,0] = [1,0,0,0,0,1,1]", "BizKodszoElso = Refl"],
      "lépések": [
        {"képlet": "az üzenet m = [1,0,0,0]", "érték": "[1, 0, 0, 0, 0, 1, 1]", "miért": "csak az első (idő) bit van bekapcsolva"},
        {"képlet": "m · G mod 2", "érték": "[1, 0, 0, 0, 0, 1, 1]", "miért": "a generátormátrix első sora: [1,0,0,0,0,1,1] — az idő bit + a fázis és mód paritások"},
        {"képlet": "a 7 bit jelentése", "érték": "[idő, okság, tér, szín, hang, fázis, mód]", "miért": "a kódszó hét dimenziója — a Steane [[7,1,3]] klasszikus alapja"}
      ],
      "szimuláció": "a Python ugyanezt a G-mátrixszal számolja (a KERNEL-be az Idris show generaloSorok kerül): kódszavak[8] = [1,0,0,0,0,1,1]; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A 16 kódszó 7 bites rácsa", "fájl": "F2.31_1.png"},
        {"cím": "SZÁMOLÁS — 4 bites üzenet → 7 bites kódszó", "fájl": "F2.31_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: első kódszó ⟷ kernel (0 = egyezik)", "fájl": "F2.31_3.png"},
        {"cím": "SPEKTRUM — A súlyeloszlás: (1, 7, 7, 1)", "fájl": "F2.31_4.png"},
        {"cím": "HÍD — Híd: kernel kódszó súlya ⟷ szimuláció súlya", "fájl": "F2.31_5.png"}
      ],
      "összefoglalóMagyar": "A Hamming [7,4,3] kód a Steane [[7,1,3]] klasszikus alapja: 4 információs bitből 7 bites kódszó. Az első kódszó az idő-bitől a fázisig és módig feszül ki.",
      "összefoglalóKínai": "汉明 [7,4,3] 码是 Steane [[7,1,3]] 的经典基础：4 信息位生成 7 位码字；首码字从时间位延伸到相位与方式。",
      "összefoglalóNémet": "Der Hamming-Code ist die klassische Grundlage des Steane-Codes: aus 4 Informationsbits wird ein 7-Bit-Codewort.",
      "összefoglalóHéber": "‏קוד המינג הוא היסוד הקלאסי של קוד Steane: מ־4 סיביות מידע נוצרת מילת קוד בת 7 סיביות."
    },
    {
      "azonosító": "F2.32",
      "címMagyar": "A mind-egyes kódszó: [1,1,1,1] → [1,1,1,1,1,1,1] (súly 7)",
      "címKínai": "全一码字：[1,1,1,1] → [1,1,1,1,1,1,1]（重量 7）",
      "címNémet": "Das All-Eins-Codewort: [1,1,1,1] → [1,1,1,1,1,1,1]",
      "címHéber": "‏מילת הקוד הכול־אחדים: [1,1,1,1] → [1,1,1,1,1,1,1]",
      "forrásModul": "szima_ter/modul/E8TizenhatPenge.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main",
      "bizonyításTípus": "BizKodszoMindEgyes : kodszamitas [1,1,1,1] = [1,1,1,1,1,1,1]",
      "kernelSzerepe": "a kernel a maximális súlyú kódszót normalizálja: mind a hét bit egyes",
      "besorolás": "VALÓDI (m·G mod 2 ⟷ kódszó)",
      "definíciók": ["public export", "BizKodszoMindEgyes : kodszamitas [1,1,1,1] = [1,1,1,1,1,1,1]", "BizKodszoMindEgyes = Refl"],
      "lépések": [
        {"képlet": "m = [1,1,1,1]", "érték": "[1, 1, 1, 1, 1, 1, 1]", "miért": "mind a négy információs bit"},
        {"képlet": "m · G mod 2", "érték": "[1, 1, 1, 1, 1, 1, 1]", "miért": "a paritások is mind egyesek lesznek"},
        {"képlet": "súly = 7", "érték": "7", "miért": "a maximális súly — az (1,7,7,1) eloszlás utolsó tagja"}
      ],
      "szimuláció": "a Python kódszavak[15] = [1,1,1,1,1,1,1], súly 7; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A 16 kódszó 7 bites rácsa", "fájl": "F2.32_1.png"},
        {"cím": "SZÁMOLÁS — A súlyok: 0, 3, 4, 7", "fájl": "F2.32_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: mind-egyes kódszó ⟷ kernel (0 = egyezik)", "fájl": "F2.32_3.png"},
        {"cím": "SPEKTRUM — A súlyeloszlás: (1, 7, 7, 1)", "fájl": "F2.32_4.png"},
        {"cím": "HÍD — Híd: kernel súly 7 ⟷ szimuláció súly 7", "fájl": "F2.32_5.png"}
      ],
      "összefoglalóMagyar": "A kód maximális súlyú szava a hét egyes: az összes dimenzió (idő…mód) egyszerre aktív. Az (1,7,7,1) eloszlás szélei: az üres és a teli szó.",
      "összefoglalóKínai": "码的最大重量字是七个一：所有维度同时激活；(1,7,7,1) 分布的两端是空词与满词。",
      "összefoglalóNémet": "Das Wort maximalen Gewichts sind sieben Einsen: alle Dimensionen gleichzeitig aktiv; die Ränder der (1,7,7,1)-Verteilung sind das leere und das volle Wort.",
      "összefoglalóHéber": "‏מילת המשקל המרבי היא שבע אחדות: כל הממדים פעילים יחד; קצוות ההתפלגות (1,7,7,1) הם המילה הריקה והמלאה."
    },
    {
      "azonosító": "F2.33",
      "címMagyar": "A súlyeloszlás összege: 1+7+7+1 = 16 — a (1,4,6,4,1) testvére",
      "címKínai": "重量分布之和：1+7+7+1 = 16——(1,4,6,4,1) 之姊妹",
      "címNémet": "Die Summe der Gewichtsverteilung: 1+7+7+1 = 16",
      "címHéber": "‏סכום התפלגות המשקלים: 1+7+7+1 = 16",
      "forrásModul": "szima_ter/modul/E8TizenhatPenge.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main",
      "bizonyításTípus": "BizSulyOsszeg : 1 + 7 + 7 + 1 = 16",
      "kernelSzerepe": "a kernel a súlyeloszlás összegét normalizálja a kódszavak számára",
      "besorolás": "KÉT ÚT (súly-binning ⟷ fokszám-binning)",
      "definíciók": ["public export", "kodSuly : List Integer -> Nat", "BizSulyOsszeg : 1 + 7 + 7 + 1 = 16", "BizSulyOsszeg = Refl"],
      "lépések": [
        {"képlet": "w=0: 1, w=3: 7, w=4: 7, w=7: 1", "érték": "1, 7, 7, 1", "miért": "futásidőben mérve a 16 kódszón (a kodSuly mindegyikén)"},
        {"képlet": "1+7+7+1", "érték": "16", "miért": "mind a 16 kódszó pontosan egy binben"},
        {"képlet": "a Hodge-tükrözés: (1,4,6,4,1) ↔ (1,7,7,1)", "érték": "a Hodge testvére", "miért": "a súly-fokszám duál a kód és a Clifford-algebra közti szerkezeti híd (a terv „testvér-szimmetriája”)"}
      ],
      "szimuláció": "a Python megszámolja a súlyokat: (1, 7, 7, 1), összeg 16; min távolság 3; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A súlyeloszlás: (1, 7, 7, 1)", "fájl": "F2.33_1.png"},
        {"cím": "SZÁMOLÁS — 1+7+7+1 → 16", "fájl": "F2.33_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: súly-összeg ⟷ kernel (Δ = 0)", "fájl": "F2.33_3.png"},
        {"cím": "SPEKTRUM — A Cl(4) fokszámai: (1, 4, 6, 4, 1) — a testvér", "fájl": "F2.33_4.png"},
        {"cím": "HÍD — Híd: (1,7,7,1) összeg ⟷ (1,4,6,4,1) összeg", "fájl": "F2.33_5.png"}
      ],
      "összefoglalóMagyar": "A 16 kódszó súly szerint 1, 7, 7, 1 — ugyanaz a palindrom minta, mint a pengék fokszámai (1,4,6,4,1). Két 16-os szerkezet, egy tükör-alak: a kód és a geometria testvérei.",
      "összefoglalóKínai": "16 个码字按重量 1,7,7,1——与刃的阶数 (1,4,6,4,1) 同为回文：码与几何是姊妹。",
      "összefoglalóNémet": "Die 16 Codewörter nach Gewicht 1, 7, 7, 1 — dasselbe Palindrom wie die Blade-Grade (1,4,6,4,1): Code und Geometrie sind Geschwister.",
      "összefoglalóHéber": "‏16 מילות הקוד לפי משקל 1, 7, 7, 1 — אותו פלינדרום כמו דרגות הלהבים: הקוד והגאומטריה אחיות."
    },
    {
      "azonosító": "F2.34",
      "címMagyar": "A 256-OS HÍD: 240 gyök (TARTALOM) + 16 penge (KERET) = 256 = 2⁸",
      "címKínai": "256 之桥：240 根（内容）+ 16 刃（框架）= 256 = 2⁸",
      "címNémet": "DIE 256-BRÜCKE: 240 Wurzeln (Inhalt) + 16 Blades (Rahmen) = 256 = 2⁸",
      "címHéber": "‏גשר 256: 240 שורשים (תוכן) + 16 להבים (מסגרת) = 256 = 2⁸",
      "forrásModul": "szima_ter/modul/E8TizenhatPenge.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main",
      "bizonyításTípus": "BizHid : 240 + 16 = 256",
      "kernelSzerepe": "a kernel a gyökök és pengék összegét normalizálja a 2⁸-hoz — KÉT FÜGGETLEN ÚT: az E8-kombinatorika (240) ÉS a Cl(4)-binomiálisok (16) ugyanabba a 256-os térbe futnak",
      "besorolás": "KÉT ÚT-HÍD (kombinatorika ⟷ binomiális)",
      "definíciók": ["public export", "BizHid : 240 + 16 = 256", "BizHid = Refl", "BizKettoNyolcadik : 256 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2"],
      "lépések": [
        {"képlet": "240 (E8 gyökök — kombinatorika, F2.05)", "érték": "240", "miért": "a tartalom: a 240 szimbólum"},
        {"képlet": "16 (Cl(4) pengék — binomiálisok, F2.27)", "érték": "16", "miért": "a keret: 1+4+6+4+1"},
        {"képlet": "240 + 16", "érték": "256", "miért": "tartalom + keret = a teljes bájt"},
        {"képlet": "2⁸ (a második út)", "érték": "256", "miért": "a nyolcbites tér — a híd megáll"}
      ],
      "szimuláció": "a Python len(e8) + len(pengék) = 240 + 16 = 256 = 2**8; Δ = 0. A SEJTÉS (a felhasználó, 2026-08-21): a 240 kódszó 16 keret-biten tárolható — ÁLLAPOT: SPECULATÍV (a számok bizonyítva, az értelmezés sejtés)",
      "grafikonok": [
        {"cím": "SZERKEZET — 240 gyök + 16 penge egy rácsban (a 16×16 mező)", "fájl": "F2.34_1.png"},
        {"cím": "SZÁMOLÁS — 240 + 16 → 256", "fájl": "F2.34_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: híd ⟷ kernel (Δ = 0)", "fájl": "F2.34_3.png"},
        {"cím": "SPEKTRUM — A (1,7,7,1) súly- ⟷ (1,4,6,4,1) fok-tükrözés", "fájl": "F2.34_4.png"},
        {"cím": "HÍD — Híd: 240+16 enumeráció ⟷ 2⁸ = 256", "fájl": "F2.34_5.png"}
      ],
      "összefoglalóMagyar": "A fejezet központi hídja: a 240 E8-gyök (tartalom) és a 16 Cl(4)-penge (keret) együtt a 256-os tér — egy bájt. A szám két úton bizonyított; az értelmezés (a kvantum-távíró sejtése) SPECULATÍV jelölésű.",
      "összefoglalóKínai": "本章核心之桥：240 个 E8 根（内容）与 16 刃（框架）合成 256 空间——一个字节；数字经两路证明，解释（量子电报猜想）标注为推测。",
      "összefoglalóNémet": "Die zentrale Brücke: 240 Wurzeln (Inhalt) und 16 Blades (Rahmen) ergeben den 256-Raum — ein Byte; die Zahlen sind auf zwei Wegen bewiesen, die Deutung SPEKULATIV markiert.",
      "összefoglalóHéber": "‏הגשר המרכזי: 240 שורשים ו־16 להבים יוצרים את מרחב 256 — בייט אחד; המספרים הוכחו בשני נתיבים, הפרשנות מסומנת כספקולטיבית."
    },
    {
      "azonosító": "F2.35",
      "címMagyar": "A 256 = 2⁸ — a híd második (hatvány-) útja",
      "címKínai": "256 = 2⁸——桥的幂路",
      "címNémet": "256 = 2⁸ — der Potenzweg der Brücke",
      "címHéber": "‏256 = 2⁸ — דרך החזקה של הגשר",
      "forrásModul": "szima_ter/modul/E8TizenhatPenge.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main",
      "bizonyításTípus": "BizKettoNyolcadik : 256 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2",
      "kernelSzerepe": "a kernel a nyolc kettes szorzatát normalizálja a 256-hoz",
      "besorolás": "KÉT ÚT (hatvány ⟷ enumeráció)",
      "definíciók": ["public export", "BizKettoNyolcadik : 256 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2", "BizKettoNyolcadik = Refl"],
      "lépések": [
        {"képlet": "2 · 2 · 2 · 2 · 2 · 2 · 2 · 2", "érték": "256", "miért": "nyolc bit: mind kétféle lehet"},
        {"képlet": "= 256", "érték": "256", "miért": "a nyolcbites kódszó-tér"},
        {"képlet": "ellenőrzés: 240 + 16", "érték": "256", "miért": "az enumeráció ugyanideér (F2.34)"}
      ],
      "szimuláció": "a Python 2**8 = 256 = len(e8) + len(pengék); Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — 240 gyök + 16 penge egy rácsban", "fájl": "F2.35_1.png"},
        {"cím": "SZÁMOLÁS — A kettő-hatvány létra 2¹…2⁸", "fájl": "F2.35_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: 2⁸ ⟷ enumeráció (Δ = 0)", "fájl": "F2.35_3.png"},
        {"cím": "SPEKTRUM — A 16 kódszó rácsa (2⁴ = 16)", "fájl": "F2.35_4.png"},
        {"cím": "HÍD — Híd: 2·2·…·2 ⟷ 240+16", "fájl": "F2.35_5.png"}
      ],
      "összefoglalóMagyar": "A 256 mint nyolc bit hatványa a híd második útja: nem számoljuk ki a 240+16 összeget, hanem a tér méretéből indulunk — a kettő ugyanoda ér.",
      "összefoglalóKínai": "256 作为八个比特的幂是桥的第二条路：不数 240+16，而由空间大小出发——二者同归。",
      "összefoglalóNémet": "256 als Potenz von acht Bits ist der zweite Weg der Brücke: nicht 240+16 gezählt, sondern von der Raumgröße her — beide kommen an.",
      "összefoglalóHéber": "‏256 כחזקת שמונה סיביות הוא הנתיב השני של הגשר: לא סופרים 240+16 אלא יוצאים מגודל המרחב — שניהם מגיעים."
    },
    {
      "azonosító": "F2.36",
      "címMagyar": "A 240 szó: az E8 gyökök mint alapszókincs — híd az F4 (nyelv) fejezethez",
      "címKínai": "240 个词：E8 根即基础词汇——通往 F4（语言）章的桥",
      "címNémet": "Die 240 Wörter: E8-Wurzeln als Grundwortschatz — Brücke zu Kapitel F4",
      "címHéber": "‏240 המילים: שורשי E8 כאוצר מילים בסיסי — גשר אל פרק F4",
      "forrásModul": "szima_ter/modul/GyokSzo_v1.idr",
      "futtatásiParancs": "idris2 szima_ter/modul/GyokSzo_v1.idr --exec main",
      "bizonyításTípus": "bizKétÚtHíd : 112 + 128 = length AlapszókincsKonst (GyokSzo_v1)",
      "kernelSzerepe": "a kernel a szókincs-lista hosszát normalizálja a kombinatorikai összeghez — a szókincs az IMPORTÁLT gyöklistákból épül (§24), semmit nem másol",
      "besorolás": "KÉT ÚT-HÍD (kombinatorika ⟷ szókincs-enumeráció) + KIINDULÓ KÁRTYA az F4-hez",
      "definíciók": ["public export", "record GyökSzó where", "  constructor GyökSzóKonstruktor", "  jel : E8Gyok", "  szóOsztály : SzóOsztály", "alapszókincs : List GyökSzó   -- egészSzavak ++ félEgészSzavak", "bizKétÚtHíd : 112 + 128 = length AlapszókincsKonst"],
      "lépések": [
        {"képlet": "egész szavak (állandó fogalmak)", "érték": "112", "miért": "a 112 típus-1 gyök burkolva (EgészGyökSzó)"},
        {"képlet": "fél-egész szavak (kapcsolati fogalmak)", "érték": "128", "miért": "a 128 típus-2 gyök burkolva (FélEgészGyökSzó)"},
        {"képlet": "alapszókincs = egészSzavak ++ félEgészSzavak", "érték": "240", "miért": "a teljes szókincs — futásidőben mérve"},
        {"képlet": "bizKétÚtHíd: 112 + 128 = length", "érték": "240", "miért": "a híd: a kombinatorika és a szókincs-enumeráció ugyanazt a 240-et adja"}
      ],
      "szimuláció": "a Python a gyököket szavakként számolja (a KERNEL-ben egész/fél-egész szószámok): 112 + 128 = 240; Δ = 0",
      "grafikonok": [
        {"cím": "SZERKEZET — A 240 szó két osztályban (112/128) — petri-vetület", "fájl": "F2.36_1.png"},
        {"cím": "SZÁMOLÁS — 112 egész + 128 fél-egész → 240 szó", "fájl": "F2.36_2.png"},
        {"cím": "ELLENŐRZÉS — Maradék: szókincs ⟷ gyökrendszer (Δ = 0)", "fájl": "F2.36_3.png"},
        {"cím": "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1) — a jelentés-távolság forrása", "fájl": "F2.36_4.png"},
        {"cím": "HÍD — Híd: 112+128 kombinatorika ⟷ alapszókincs hossza", "fájl": "F2.36_5.png"}
      ],
      "összefoglalóMagyar": "A 240 gyök egyszerre 240 szó: a 112 egész gyök állandó fogalom, a 128 fél-egész kapcsolati fogalom. Ez a kártya az F4 (a 3 dimenziós nyelv) fejezet kapuja — a számok innen, a jelentés onnan.",
      "összefoglalóKínai": "240 个根同时是 240 个词：112 整数根为恒常概念，128 半整数根为关系概念——此卡是 F4（三维语言）章之门：数字由此来，意义由彼来。",
      "összefoglalóNémet": "Die 240 Wurzeln sind zugleich 240 Wörter: 112 ganze für beständige Begriffe, 128 halbzahlige für Beziehungsbegriffe — das Tor zu Kapitel F4.",
      "összefoglalóHéber": "‏240 השורשים הם גם 240 מילים: 112 שלמים למושגים קבועים, 128 חצאים למושגי יחס — השער לפרק F4."
    }
  ]
};
