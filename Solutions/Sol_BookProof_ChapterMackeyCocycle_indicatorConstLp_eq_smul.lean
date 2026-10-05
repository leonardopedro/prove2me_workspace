-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.indicatorConstLp_eq_smul
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable {μ : Measure X} [IsFiniteMeasure μ]

set_option maxHeartbeats 1000000 in
theorem solution {E : Set X} (hE : MeasurableSet E) (hμE : μ E ≠ ⊤) (c : ℂ) :
    indicatorConstLp 2 hE hμE c = c • indSet μ hE := by

  refine Lp.ext ?_
  filter_upwards [indicatorConstLp_coeFn (μ := μ) (p := 2) (s := E) (hs := hE)
      (hμs := hμE) (c := c),
    Lp.coeFn_smul c (indSet μ hE),
    indicatorConstLp_coeFn (μ := μ) (p := 2) (s := E) (hs := hE)
      (hμs := measure_ne_top μ E) (c := (1 : ℂ))] with x e1 e2 e3
  simp only [Pi.smul_apply] at e2
  rw [e1, e2, indSet, e3]
  by_cases hx : x ∈ E <;> simp [hx]
