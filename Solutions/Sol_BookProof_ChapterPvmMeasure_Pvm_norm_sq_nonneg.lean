-- Generated from ChapterPvmMeasure.lean — solution of BookProof.ChapterPvmMeasure.Pvm.norm_sq_nonneg
import Mathlib
import Definitions.Def_ChapterPvmMeasure
open BookProof.ChapterPvmMeasure



open MeasureTheory
open scoped InnerProductSpace


variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H)

set_option maxHeartbeats 1000000 in
theorem solution (E : Set X) (u : H) : 0 ≤ ‖P.p E u‖ ^ 2 := by
 positivity
