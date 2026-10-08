-- Generated from ChapterPvmMeasure.lean — theorem BookProof.ChapterPvmMeasure.pvm_eq_zero_of_measure_zero
import Mathlib
import Definitions.Def_ChapterPvmMeasure
open BookProof.ChapterPvmMeasure


open MeasureTheory
open scoped InnerProductSpace


variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable (P : Pvm X H)
variable (P : Pvm X H) (ψ : H)

theorem BookProof.ChapterPvmMeasure.pvm_eq_zero_of_measure_zero (hcyc : IsCyclic P ψ) {E : Set X} (hE : MeasurableSet E)
    (h0 : pvmMeasure P ψ E = 0) : P.p E = 0 := by sorry
