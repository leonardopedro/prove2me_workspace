-- Generated from ChapterMackeyQuasiInvariant.lean — theorem BookProof.ChapterMackeyQuasiInvariant.proj_symm
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



theorem BookProof.ChapterMackeyQuasiInvariant.proj_symm (μ : Measure X) {E : Set X} (hE : MeasurableSet E) (f f' : Lp K 2 μ) :
    (inner ℂ (proj μ hE f) f' : ℂ) = inner ℂ f (proj μ hE f') := by sorry
