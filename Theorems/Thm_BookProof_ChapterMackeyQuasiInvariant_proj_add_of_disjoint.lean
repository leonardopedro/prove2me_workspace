-- Generated from ChapterMackeyQuasiInvariant.lean — theorem BookProof.ChapterMackeyQuasiInvariant.proj_add_of_disjoint
import Mathlib
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterMackeyQuasiInvariant


open MeasureTheory Measure


variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable (μ : Measure X) (L : G → X → (K ≃ₗᵢ[ℂ] K))
variable {μ L}

theorem BookProof.ChapterMackeyQuasiInvariant.proj_add_of_disjoint (μ : Measure X) {E F : Set X} (hE : MeasurableSet E)
    (hF : MeasurableSet F) (hd : Disjoint E F) (f : Lp K 2 μ) :
    proj μ (hE.union hF) f = proj μ hE f + proj μ hF f := by sorry
