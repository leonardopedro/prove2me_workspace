-- Generated from ChapterPvmCyclicUnitary.lean — theorem BookProof.ChapterPvmCyclicUnitary.pvm_cyclic_unitary
import Definitions.Def_ChapterPvmMeasure
import Definitions.Def_ChapterMackeyQuasiInvariant
import Mathlib
import Definitions.Def_ChapterPvmCyclicUnitary
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterPvmCyclicUnitary

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H) (ψ : H)
variable [CompleteSpace H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterMackeyQuasiInvariant

attribute [local instance] Lp.simpleFunc.module Lp.simpleFunc.normedSpace


theorem BookProof.ChapterPvmCyclicUnitary.pvm_cyclic_unitary (P : Pvm X H) (ψ : H) (hcyc : IsCyclic P ψ) :
    ∃ W : Lp ℂ 2 (pvmMeasure P ψ) ≃ₗᵢ[ℂ] H,
      (∀ (E : Set X) (hE : MeasurableSet E),
          W (indicatorConstLp 2 hE (measure_ne_top (pvmMeasure P ψ) E) (1 : ℂ)) = P.p E ψ) ∧
      (∀ (E : Set X) (hE : MeasurableSet E) (f : Lp ℂ 2 (pvmMeasure P ψ)),
          W (proj (pvmMeasure P ψ) hE f) = P.p E (W f)) := by sorry
