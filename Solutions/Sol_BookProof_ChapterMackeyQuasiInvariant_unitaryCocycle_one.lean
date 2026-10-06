-- Generated from ChapterMackeyQuasiInvariant.lean — solution of BookProof.ChapterMackeyQuasiInvariant.unitaryCocycle_one
import Mathlib
import Definitions.Def_ChapterMackeyQuasiInvariant
open BookProof.ChapterMackeyQuasiInvariant



open MeasureTheory Measure


variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) :
    UnitaryCocycle (G := G) (K := K) μ (fun _ _ => LinearIsometryEquiv.refl ℂ K) where
  one :=
  where
    one := by intro x v; rfl
    mul := by intro g k x v; rfl
    aesm := by intro g f hf; exact hf
