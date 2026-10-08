-- Generated from ChapterMackeyQuasiInvariant.lean — theorem BookProof.ChapterMackeyQuasiInvariant.unitaryCocycle_one
import Mathlib
import Definitions.Def_ChapterMackeyQuasiInvariant
open BookProof.ChapterMackeyQuasiInvariant


open MeasureTheory Measure


variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]


theorem BookProof.ChapterMackeyQuasiInvariant.unitaryCocycle_one (μ : Measure X) :
    UnitaryCocycle (G := G) (K := K) μ (fun _ _ => LinearIsometryEquiv.refl ℂ K) where
  one := by sorry
