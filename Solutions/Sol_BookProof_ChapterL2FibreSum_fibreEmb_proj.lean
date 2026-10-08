-- Generated from ChapterL2FibreSum.lean — solution of BookProof.ChapterL2FibreSum.fibreEmb_proj
import Mathlib
import Definitions.Def_ChapterL2FibreSum
import Theorems.Thm_BookProof_ChapterMackeyQuasiInvariant_proj_coeFn
open BookProof.ChapterL2FibreSum



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X] {μ : Measure X}

variable {X : Type*} [MeasurableSpace X] {μ : Measure X}
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) (i : ι) {E : Set X} (hE : MeasurableSet E)
    (f : Lp ℂ 2 μ) :
    fibreEmb μ i (proj μ hE f) = proj μ hE (fibreEmb μ i f) := by

  refine Lp.ext ?_
  filter_upwards [fibreEmb_coeFn μ i (proj μ hE f), proj_coeFn μ hE f,
    proj_coeFn (K := Fibre ι) μ hE (fibreEmb μ i f), fibreEmb_coeFn μ i f] with x e1 e2 e3 e4
  rw [e1, e2, e3]
  by_cases hx : x ∈ E <;> simp [hx, e4]
