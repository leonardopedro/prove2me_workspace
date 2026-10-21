-- Generated from ChapterMackeyQuasiInvariant.lean — solution of BookProof.ChapterMackeyQuasiInvariant.proj_inter
import Mathlib
import Definitions.Def_ChapterMackeyQuasiInvariant
import Theorems.Thm_BookProof_ChapterMackeyQuasiInvariant_proj_coeFn
open BookProof.ChapterMackeyQuasiInvariant



open MeasureTheory Measure


variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable (μ : Measure X) (L : G → X → (K ≃ₗᵢ[ℂ] K))
variable {μ L}

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {E F : Set X} (hE : MeasurableSet E) (hF : MeasurableSet F)
    (f : Lp K 2 μ) : proj μ hE (proj μ hF f) = proj μ (hE.inter hF) f := by

  refine Lp.ext ?_
  filter_upwards [proj_coeFn μ hE (proj μ hF f), proj_coeFn μ hF f,
    proj_coeFn μ (hE.inter hF) f] with x e1 e2 e3
  by_cases hx : x ∈ E <;> by_cases hy : x ∈ F <;>
    simp [e1, e2, e3, hx, hy]
