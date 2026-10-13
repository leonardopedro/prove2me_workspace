-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.quadForm_secDiag_eq
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded
open BookProof.ScalaronEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)
variable {ι : Type*}
variable (Q : QgModeData ι)
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in

theorem solution (x : secCore (ι := ι)) {P : Finset ι}
    (hP1 : ∀ a, a ∉ P → (x : Sec ι) a = 0) :
    quadForm (secDiag W Q) x = ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (fibOf x a) := by
  rw [quadForm, inner_eq_sum_of_supp P (x : Sec ι) (secDiag W Q x) hP1, Complex.re_sum]
  rfl
