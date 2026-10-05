-- Generated from ChapterScalaronOuterFockFL.lean — theorem BookProof.ScalaronOuterFockFL.norm_sub_conj_eq
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterWallEsaSemibounded
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
open BookProof.ScalaronOuterFockFL

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)
variable {ι : Type*}
variable (Q : QgModeData ι)
variable (W : WallPot) (Q : QgModeData ι)



open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

theorem BookProof.ScalaronOuterFockFL.norm_sub_conj_eq (z : ℂ) : ‖z - (starRingEnd ℂ) z‖ = 2 * |z.im| := by
  rw [Complex.sub_conj]
  simp

/-- The vielbein self-interaction contributes at most `½K` times the quadratic form to the
commutator. -/
theorem imA_le (x : secCore (ι := by sorry
