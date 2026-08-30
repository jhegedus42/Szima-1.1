module KöltőiEszköz_v1_Szima

import Decidable.Equality

%default total

-- ============================================================
-- idris-mag / T5: Költői eszközök algebraja
-- ============================================================
-- Joco irányelv (2026-08-24):
--   "a hasonlatokra kell koncentrálunk, az adja meg az igazi
--    jelentést és intelligenciát"
--   "ezek lesznek neked a tuti antihallu szteroidok"
--   "arisztotelesznek is vannak logikai bukfencei, amik már
--    3-6 mondaton keresztül is átívelnek"
--
-- Kutatási alap (2026-08-24):
--   Ott–Jäkel arXiv:2505.19792: analógia = FUNKTOR
--     domén-kategóriák közt; pullback = mag; pushout = blend.
--   Gentner 1983: Structure-Mapping; systematicity elv.
--   Fuyama–Saigo–Takahashi arXiv:2604.10035 (TINT):
--     metafora = nat.transzformáció coslice-kat. közt.
--
-- Alapgondolat: a hasonlat EXPLICIT FUNKTOR-DEKLARÁCIÓ.
-- Aki hasonlatot mond, annak meg kell mondania az invariánst.
-- A hallucináció = deklarálatlan lekérdezés = típushiba.
-- ============================================================

-- -----------------------------------------------------------
-- 1. Fogalom — a jelentéstér csomópontja
-- -----------------------------------------------------------
||| Fogalom: kód + tömeg (a JelentesTer.Szó-val konzisztens).
public export
record Fogalom where
  constructor FogalomKészít
  kód    : Nat
  tömeg  : Nat

%name Fogalom f, f'

-- -----------------------------------------------------------
-- 2. Reláció — a domén szerkezeti eleme
-- -----------------------------------------------------------
||| Reláció két fogalom közt, típus-címkével.
||| A Gentner-struktúramapping szerint a RELÁCIÓK azok,
||| amik átmegynek a hasonlatban (nem az attribútumok).
public export
record Reláció where
  constructor RelációKészít
  honnanRel : Nat
  hováRel   : Nat
  ||| Reláció-típus: ok-okozat(0), tulajdonság(1), rész-egész(2),
  ||| hasonlóság(3), sorrend(4), ellenét(5)...
  típus     : Nat

%name Reláció r, r'

-- -----------------------------------------------------------
-- 3. Domén — fogalmak + relációk (mini-kategória)
-- -----------------------------------------------------------
||| Egy domén: fogalom-lista + reláció-lista.
||| Ez az Ott–Jäkel-féle domain category diszkrét váza.
public export
record Domén where
  constructor DoménKészít
  fogalmak  : List Fogalom
  relációk  : List Reláció

%name Domén d, d'

-- -----------------------------------------------------------
-- 4. Hasonlat — EXPLICIT funktor-deklaráció
-- -----------------------------------------------------------
||| Hasonlat: forrás-domén -> cél-domén leképezés,
||| MEGADVA az invariáns relációkat.
|||
||| Anti-hallucinációs elv: aki hasonlatot mond, annak ki kell
||| mondania, MI MARAD MEG. Amit nem mond meg, az nem része
||| a hasonlatnak — rákérdezni TILOS (típushiba lenne).
public export
record Hasonlat where
  constructor HasonlatKészít
  ||| Forrás (alap) domén — a "mint a ..." oldal.
  forrás      : Domén
  ||| Cél-domén — amit leírunk.
  cél         : Domén
  ||| Az ÁTVITT relációk maguk — csak ezek mennek át,
||| minden más NEM része a hasonlatnak.
  invariánsRelációk : List Reláció

%name Hasonlat h, h'

-- -----------------------------------------------------------
-- 5. Hasonlat erőssége — systematicity
-- -----------------------------------------------------------
||| Gentner systematicity: minél több MAGASABBRENDELT reláció
||| (ok-okozat, típus==0) megy át, annál erősebb a hasonlat.
export
hasonlatErősség : Hasonlat -> Nat
hasonlatErősség h = okoSzám (invariánsRelációk h)
  where
    okoSzám : List Reláció -> Nat
    okoSzám [] = 0
    okoSzám (r :: többi) =
      if típus r == 0 then S (okoSzám többi) else okoSzám többi

-- -----------------------------------------------------------
-- 6. Bukfenc-típusok — a logikai hibák felsorolása
-- -----------------------------------------------------------
||| Arisztotelész-i logikai hibák diszkrét katalógusa.
||| Minden bukfenc TÍPUSTALÁLKOZÁSI HIBA formálisan:
||| olyan következtetés, amihoz nem létezik bizonyíték-típus.
public export
data Bukfenc
  = MegfordítottKövetkezmény  -- P->Q, Q |- P (nincs P-bizonyíték)
  | Előfeltételezés           -- begyepesedett kör
  | HamisDichotómia           -- csak 2 opció, holott több van
  | EmberAlapú                -- ad hominem
  | SalmónSzalma              -- gyenge hasonlat erősnek véle
  | Utolsónyilas              -- post hoc ergo propter hoc

%name Bukfenc b

-- -----------------------------------------------------------
-- 7. Bukfenc-detektálás — a hasonlat túllépése
-- -----------------------------------------------------------
||| Hossz (Nat) saját definícióval.
hosszN : List a -> Nat
hosszN [] = 0
hosszN (_ :: xs) = S (hosszN xs)

||| Kisebb-vagy-egyenlő (Nat), konstruktor-redukcióval.
lteNat2 : Nat -> Nat -> Bool
lteNat2 Z _ = True
lteNat2 (S _) Z = False
lteNat2 (S k) (S m) = lteNat2 k m

||| Ha egy hasonlat TÖBB relációt állít átvenni,
||| mint amennyit az invariánsok deklarálnak — az
||| SalmónSzalma bukfenc: gyenge hasonlatot erősnek venni.
|||
||| Diszkrét detektor: a cél-doménben található relációk
||| száma > invariánsok száma -> gyanús túllépés.
export
túllépiEAInvariánst : Hasonlat -> Bool
túllépiEAInvariánst h =
  lteNat2 (hosszN (invariánsRelációk h)) (hosszN (relációk (cél h)))

-- -----------------------------------------------------------
-- 8. Példa: "A naprendszer mint atom"
-- -----------------------------------------------------------
||| Forrás: Naprendszer (nap, bolygó; köröz-okozat)
naprendszerDomén : Domén
naprendszerDomén = DoménKészít
  [ FogalomKészít 1 10  -- nap
  , FogalomKészít 2 5 ] -- bolygó
  [ RelációKészít 2 1 0 ] -- bolygó körözi napot (ok-okozat)

||| Cél: hidrogénatom (mag, elektron)
atomDomén : Domén
atomDomén = DoménKészít
  [ FogalomKészít 1 10  -- mag
  , FogalomKészít 2 1 ] -- elektron
  [ RelációKészít 2 1 0 ] -- elektron vonzódik/köröz magot

||| A klasszikus Gentner-analógia: naprendszer ~ atom.
||| Invariáns: a körözés-reláció átmegy.
napAtomHasonlat : Hasonlat
napAtomHasonlat = HasonlatKészít
  naprendszerDomén
  atomDomén
  [ RelációKészít 2 1 0 ]

||| Nagybetűs alias (a kisbetűs-csapda ellen).
export
NapAtomHasonlat : Hasonlat
NapAtomHasonlat = napAtomHasonlat

||| Bizonyítás: az invariáns-ok száma 1 (egy ok-okozat ment át).
bizNapAtomErős : hasonlatErősség NapAtomHasonlat = 1
bizNapAtomErős = ?bizNapAtomLyuk

-- -----------------------------------------------------------
-- 9. A fő anti-hallucinációs tétel
-- -----------------------------------------------------------
||| TÉTEL-VÁZLAT (formalizálandó): ha egy állítás hasonlatként
||| van deklarálva, akkor CSAK az invariáns relációkra lehet
||| hivatkozni a következtetésben. Minden más referencia
||| SalmónSzalma-bukfenc.
|||
||| Ez azért fontos: így a hallucináció FORMÁLISAN DETEKTÁLHATÓ —
||| nem stílus kérdése, hanem típusellenőrzésé.
||| nem stílus kérdése, hanem típusellenőrzésé.

-- -----------------------------------------------------------
-- 10. Rendszer-metafora — a KÜLVÁROSI ÉJ szintje
-- -----------------------------------------------------------
||| Magasabbrendű metafora: nem IZOLÁLT relációk mennek át,
||| hanem EGY MŰKÖDÉSI RENDSZER (morfizmus-diagram).
|||
||| József Attila: Külvárosi éj példák:
|||   - álom = szövött anyag (gyári logika átvitele)
|||   - sötét = gyártott termék ("a csönd talapzata")
|||   - penész = térképész (mikro-minta = makro-térkép)
|||   - éj = kovácsműhely (teljes ipari lánc a szívben)
|||
||| Gentner systematicity MAXIMÁLISA: kommutáló diagram.
public export
record RendszerMetafora where
  constructor RendszerMetaforaKészít
  ||| Forrás-domén (a működő rendszer otthona).
  forrásRendszer   : Domén
  ||| Cél-domén (ahova a rendszer logikája költözik).
  célRendszer      : Domén
  ||| Az átvitt relációk MIND — ezek együtt alkotnak
  ||| kommutáló diagramot: ha f∘g átment, akkor g'∘f' is.
  átmenyRelációk   : List Reláció
  ||| A diagram kommutativitásának jele (diszkrét):
  ||| minden átment relációnak van páros partnere.
  kommutációJeles  : Bool

||| Példa: az álom-szövés (szövőgyár → álomgyártás).
export
alomSzoves : RendszerMetafora
alomSzoves = RendszerMetaforaKészít
  (DoménKészít
    [ FogalomKészít 1 8   -- holdsugár (fonál-alapanyag)
    , FogalomKészít 2 6   -- szövőszék
    , FogalomKészít 3 4 ] -- szövőnő álama (késztermék)
    [ RelációKészít 1 2 0 -- a fény fonallá alakul (ok-okozat)
    , RelációKészít 2 3 0 ] ) -- a szövőszék álmot gyárt (ok-okozat)
  (DoménKészít
    [ FogalomKészít 1 8   -- éjszakai fény a gyárban
    , FogalomKészít 2 6   -- a gép/munka
    , FogalomKészít 3 4 ] -- a szövőnő omló álma
    [ RelációKészít 1 2 0 -- a fény anyaggá válik
    , RelációKészít 2 3 0 ])-- a munkából álom szövődik
  [ RelációKészít 1 2 0, RelációKészít 2 3 0 ]
  True

||| Nagybetűs alias (a kisbetűs-csapda ellen).
export
AlomSzoves : RendszerMetafora
AlomSzoves = alomSzoves

||| Bizonyítás-vázlat: az álom-szövés rendszer-metafora.
||| Két ok-okozati reláció ment át (kommutáló pár).
bizAlomSzovesErős : hasonlatErősség
  (HasonlatKészít (forrásRendszer AlomSzoves)
                  (célRendszer AlomSzoves)
                  (átmenyRelációk AlomSzoves)) = 2
bizAlomSzovesErős = ?bizAlomLyuk

-- -----------------------------------------------------------
-- Visszaállítva: a hallucináció-detektor
-- -----------------------------------------------------------
||| Ha egy hasonlat TÖBB relációt állít átvenni, mint amennyit
||| deklarált — az SalmónSzalma bukfenc. A detektor ezt jelzi.
export
hallucinacioDetektor : Hasonlat -> Maybe Bukfenc
hallucinacioDetektor h =
  if túllépiEAInvariánst h then Just SalmónSzalma else Nothing
