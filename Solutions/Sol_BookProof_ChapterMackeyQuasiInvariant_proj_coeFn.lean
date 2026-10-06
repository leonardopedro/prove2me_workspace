-- Generated from ChapterMackeyQuasiInvariant.lean — solution of BookProof.ChapterMackeyQuasiInvariant.proj_coeFn
import Mathlib
import Definitions.Def_ChapterMackeyQuasiInvariant
open BookProof.ChapterMackeyQuasiInvariant



open MeasureTheory Measure


variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable (μ : Measure X) (L : G → X → (K ≃ₗᵢ[ℂ] K))
variable {μ L}

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {E : Set X} (hE : MeasurableSet E) (f : Lp K 2 μ) :
    (proj μ hE f : X → K) =ᵐ[μ] E.indicator (f : X → K) := MemLp.coeFn_toLp _
