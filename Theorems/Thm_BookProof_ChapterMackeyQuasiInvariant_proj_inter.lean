-- Generated from ChapterMackeyQuasiInvariant.lean — theorem BookProof.ChapterMackeyQuasiInvariant.proj_inter
import Mathlib
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterMackeyQuasiInvariant

variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable (μ : Measure X) (L : G → X → (K ≃ₗᵢ[ℂ] K))
variable {μ L}


open MeasureTheory Measure



theorem BookProof.ChapterMackeyQuasiInvariant.proj_inter (μ : Measure X) {E F : Set X} (hE : MeasurableSet E) (hF : MeasurableSet F)
    (f : Lp K 2 μ) : proj μ hE (proj μ hF f) = proj μ (hE.inter hF) f := by sorry
