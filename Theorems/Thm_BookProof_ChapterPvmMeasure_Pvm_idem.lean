-- Generated from ChapterPvmMeasure.lean — theorem BookProof.ChapterPvmMeasure.Pvm.idem
import Mathlib
import Definitions.Def_ChapterPvmMeasure
open BookProof.ChapterPvmMeasure
open BookProof.ChapterPvmMeasure


open MeasureTheory
open scoped InnerProductSpace


variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable (P : Pvm X H)

theorem BookProof.ChapterPvmMeasure.Pvm.idem {E : Set X} (hE : MeasurableSet E) (u : H) : P.p E (P.p E u) = P.p E u := by sorry
