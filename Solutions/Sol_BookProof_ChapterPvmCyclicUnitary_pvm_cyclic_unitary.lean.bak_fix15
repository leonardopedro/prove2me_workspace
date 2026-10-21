-- Generated from ChapterPvmCyclicUnitary.lean — solution of BookProof.ChapterPvmCyclicUnitary.pvm_cyclic_unitary
import Mathlib
import Definitions.Def_ChapterPvmCyclicUnitary
import Theorems.Thm_BookProof_ChapterPvmCyclicUnitary_swCLM_proj
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
theorem solution (P : Pvm X H) (ψ : H) (hcyc : IsCyclic P ψ) :
    ∃ W : Lp ℂ 2 (pvmMeasure P ψ) ≃ₗᵢ[ℂ] H,
      (∀ (E : Set X) (hE : MeasurableSet E),
          W (indicatorConstLp 2 hE (measure_ne_top (pvmMeasure P ψ) E) (1 : ℂ)) = P.p E ψ) ∧
      (∀ (E : Set X) (hE : MeasurableSet E) (f : Lp ℂ 2 (pvmMeasure P ψ)),
          W (proj (pvmMeasure P ψ) hE f) = P.p E (W f)) :=
  ⟨swEquiv P ψ hcyc, fun _ hE => swCLM_indicator P ψ hE,
      fun _ hE f => swCLM_proj P ψ hE f⟩
