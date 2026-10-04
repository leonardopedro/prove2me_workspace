-- Generated from ChapterPvmMeasure.lean — theorem BookProof.ChapterPvmMeasure.pvmMeasure_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterPvmMeasure
import Definitions.Def_ChapterA4
open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H)
variable (P : Pvm X H) (ψ : H)


open MeasureTheory
open scoped InnerProductSpace



theorem BookProof.ChapterPvmMeasure.pvmMeasure_eq_zero_iff {E : Set X} (hE : MeasurableSet E) :
    pvmMeasure P ψ E = 0 ↔ P.p E ψ = 0 := by sorry
