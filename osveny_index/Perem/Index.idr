module Perem.Index

import Steane713
import Emberi.Index
import Szamitasi.Index
import Fizika.Legendre

||| Perem = Legendre transzformacio a kvantum (emberi) es klasszikus (szamitasi) kozott.
|||   H = p·q̇ - L
|||   Emberi oldal: L (Lagrange = fazis/allapot geometria)
|||   Szamitasi oldal: H (Hamilton = utem/energia dinamika)
|||   Perem: p·q̇ (Yoneda parositas = informacio atvitel)
|||
||| A perem a [[15,1,3]] kodban az 1 (perem bit):
|||   7 emberi + 7 szamitasi + 1 perem = 15 + 1 = 16 allapot.
public export
data Perem : Type where
  PeremKonstruktor : (p : Double) -> (qdot : Double) -> (l : Double) -> Perem

||| Legendre transzformacio: H = p·q̇ - L
|||   p = kanonikus impulzus (emberi, akarat)
|||   q̇ = sebesseg (szamitasi, clock)
|||   L = Lagrange (emberi, geometria)
|||   H = Hamilton (szamitasi, energia)
public export
legendrePerem : (p : Double) -> (qdot : Double) -> (l : Double) -> Double
legendrePerem p qdot l = p * qdot - l

||| Perem a [[7,1,3]] kodban: a Legendre parositas
||| az emberi Fazis es a szamitasi Allapot kozott.
|||   Emberi.Fazis = L (Lagrange = lehetosegek tere)
|||   Szamitasi.Allapot = H (Hamilton = idofejlesztes)
|||   Perem.p·q̇ = Yoneda ertekeles = informacio atadas
public export
emberiFazisPeremSzamitasiAllapot : EmberiKategoria -> SzamitasiKategoria -> Kubit -> Kubit -> Kubit
emberiFazisPeremSzamitasiAllapot EmberiFazis SzamAllapot e s =
  if e == s then e else Nulla  -- ha a fazis allapot nem egyezik, a perem nem tudja atvinni
emberiFazisPeremSzamitasiAllapot _ _ _ _ = Nulla

||| Legendre adjunkcio tipus: Emberi.Fazis -| Perem -| Szamitasi.Allapot.
||| A perem a bal es jobb adjungalt kozotti híd.
|||   balAdj: EmberiFazis → Perem (L → p·q̇: geometria beagyazasa a perembe)
|||   jobbAdj: Perem → SzamitasiAllapot (p·q̇ → H: perem kivettese a dinamikara)
public export
record LegendreAdjunkcio where
  constructor LegendreAdjunkcioKonstruktor
  balAdj : (EmberiAllapot -> Perem)
  jobbAdj : (Perem -> SzamitasiAllapot)
  -- A ket adjungalt kompozicioja az azonos:
  --   jobbAdj ∘ balAdj ≅ id_Emberi  (Fazis visszaallitasa)
  --   balAdj ∘ jobbAdj ≅ id_Szamitasi (Allapot visszaallitasa)

||| A Legendre adjunkcio peldanya: linearis modellben
|||   balAdj (EmberiFazis, k) = PeremConstruct 1.0 1.0 0.0  (L = 0)
|||   jobbAdj (PeremConstruct 1.0 1.0 0.0) = (SzamAllapot, k)
public export
peldaLegendreAdjunkcio : LegendreAdjunkcio
peldaLegendreAdjunkcio =
  LegendreAdjunkcioKonstruktor
    (\(_, k) => PeremKonstruktor 1.0 1.0 0.0)
    (\_ => (SzamAllapot, Nulla))
