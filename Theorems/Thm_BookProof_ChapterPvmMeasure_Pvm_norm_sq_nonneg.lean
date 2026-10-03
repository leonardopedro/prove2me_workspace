-- Generated from ChapterPvmMeasure.lean — theorem BookProof.ChapterPvmMeasure.Pvm.norm_sq_nonneg
import Mathlib
import Definitions.Def_ChapterPvmMeasure
import Definitions.Def_ChapterA4

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H)


open MeasureTheory
open scoped InnerProductSpace



theorem BookProof.ChapterPvmMeasure.Pvm.norm_sq_nonneg (E : Set X) (u : H) : 0 ≤ ‖P.p E u‖ ^ 2 := by sorry
