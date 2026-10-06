-- Generated from ChapterPvmMeasure.lean — solution of BookProof.ChapterPvmMeasure.Pvm.idem
import Mathlib
import Definitions.Def_ChapterPvmMeasure
open BookProof.ChapterPvmMeasure
open BookProof.ChapterPvmMeasure.Pvm



open MeasureTheory
open scoped InnerProductSpace


variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H)

set_option maxHeartbeats 1000000 in
theorem solution {E : Set X} (hE : MeasurableSet E) (u : H) : P.p E (P.p E u) = P.p E u := by

  rw [P.inter hE hE u, Set.inter_self]
