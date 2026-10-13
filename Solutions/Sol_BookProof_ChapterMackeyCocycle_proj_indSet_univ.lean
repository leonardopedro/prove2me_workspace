-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.proj_indSet_univ
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Theorems.Thm_BookProof_ChapterMackeyQuasiInvariant_proj_coeFn
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterElectroweakFieldStrength

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

set_option maxHeartbeats 1000000 in

theorem solution (μ : Measure X) [IsFiniteMeasure μ] {E : Set X}
    (hE : MeasurableSet E) :
    proj μ hE (indSet μ (MeasurableSet.univ (α := X))) = indSet μ hE := by
  refine Lp.ext ?_
  filter_upwards [proj_coeFn μ hE (indSet μ (MeasurableSet.univ (α := X))),
    indicatorConstLp_coeFn (μ := μ) (p := 2) (s := (Set.univ : Set X))
      (hs := MeasurableSet.univ) (hμs := measure_ne_top μ Set.univ) (c := (1 : ℂ)),
    indicatorConstLp_coeFn (μ := μ) (p := 2) (s := E)
      (hs := hE) (hμs := measure_ne_top μ E) (c := (1 : ℂ))] with x e1 e2 e3
  rw [indSet, indSet]
  rw [indSet] at e1
  rw [e1, e3]
  by_cases hx : x ∈ E
  · simp only [Set.indicator_of_mem hx, e2, Set.indicator_of_mem (Set.mem_univ x)]
  · simp only [Set.indicator_of_notMem hx]

/-! ## The set-up: a covariant unitary representation -/
