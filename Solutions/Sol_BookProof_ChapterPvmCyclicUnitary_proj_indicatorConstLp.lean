-- Generated from ChapterPvmCyclicUnitary.lean — solution of BookProof.ChapterPvmCyclicUnitary.proj_indicatorConstLp
import Mathlib
import Definitions.Def_ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicUnitary



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterMackeyQuasiInvariant

attribute [local instance] Lp.simpleFunc.module Lp.simpleFunc.normedSpace

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H) (ψ : H)
variable [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {E F : Set X} (hE : MeasurableSet E) (hF : MeasurableSet F) :
    proj (pvmMeasure P ψ) hE
        (indicatorConstLp 2 hF (measure_ne_top (pvmMeasure P ψ) F) (1 : ℂ))
      = indicatorConstLp 2 (hE.inter hF) (measure_ne_top (pvmMeasure P ψ) (E ∩ F)) (1 : ℂ) := by

  refine Lp.ext ?_
  filter_upwards [proj_coeFn (pvmMeasure P ψ) hE
      (indicatorConstLp 2 hF (measure_ne_top (pvmMeasure P ψ) F) (1 : ℂ)),
    indicatorConstLp_coeFn (μ := pvmMeasure P ψ) (p := 2) (s := F)
      (hs := hF) (hμs := measure_ne_top (pvmMeasure P ψ) F) (c := (1 : ℂ)),
    indicatorConstLp_coeFn (μ := pvmMeasure P ψ) (p := 2) (s := E ∩ F)
      (hs := hE.inter hF) (hμs := measure_ne_top (pvmMeasure P ψ) (E ∩ F)) (c := (1 : ℂ))]
    with x e1 e2 e3
  rw [e1, e3]
  by_cases hx : x ∈ E <;> by_cases hy : x ∈ F <;>
    simp [Set.indicator_apply, e2, hx, hy]
