-- Generated from ChapterScalaronOuterFockFL.lean — theorem BookProof.ScalaronOuterFockFL.secHam_commForm_le
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

theorem BookProof.ScalaronOuterFockFL.secHam_commForm_le (x : secCore (ι := ι)) :
    |commForm (secHam W Q) (secDiag W Q) x| ≤ (6 * Q.K) * quadForm (secDiag W Q) x := by sorry
