-- Generated from ChapterPvmMeasure.lean — theorem BookProof.ChapterPvmMeasure.pvm_eq_zero_of_measure_zero
import Mathlib
import Definitions.Def_ChapterPvmMeasure
open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H)
variable (P : Pvm X H) (ψ : H)


open MeasureTheory
open scoped InnerProductSpace



theorem BookProof.ChapterPvmMeasure.pvm_eq_zero_of_measure_zero (hcyc : IsCyclic P ψ) {E : Set X} (hE : MeasurableSet E)
    (h0 : pvmMeasure P ψ E = 0) : P.p E = 0 := by sorry
