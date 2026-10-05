-- Generated from ChapterPvmMeasure.lean — theorem BookProof.ChapterPvmMeasure.Pvm.add_of_disjoint
import Mathlib
import Definitions.Def_ChapterPvmMeasure
open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H)


open MeasureTheory
open scoped InnerProductSpace



theorem BookProof.ChapterPvmMeasure.Pvm.add_of_disjoint {E F : Set X} (hE : MeasurableSet E) (hF : MeasurableSet F)
    (hd : Disjoint E F) (u : H) : P.p (E ∪ F) u = P.p E u + P.p F u := by sorry
