-- Generated from ChapterMackeyQuasiInvariant.lean — solution of BookProof.ChapterMackeyQuasiInvariant.proj_symm
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
theorem solution (μ : Measure X) {E : Set X} (hE : MeasurableSet E) (f f' : Lp K 2 μ) :
    (inner ℂ (proj μ hE f) f' : ℂ) = inner ℂ f (proj μ hE f') := by

  rw [L2.inner_def, L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [proj_coeFn μ hE f, proj_coeFn μ hE f'] with x e1 e2
  by_cases hx : x ∈ E <;> simp [e1, e2, hx]
