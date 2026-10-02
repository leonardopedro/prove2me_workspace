-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.secHam_apply
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.WallEsaSemibounded

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)
variable {ι : Type*}
variable (Q : QgModeData ι)
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (x : secCore (ι := ι)) (a : ι) :
    (secHam W Q x : Sec ι) a = W.ham (Q.sig a) (fibOf x a)
      + (∑ b ∈ Q.nbr a, Q.A a b • ((fibOf x b : ccDomain ℝ) : L2R))
      + ∑ b ∈ Q.nbr a, Q.B a b • xCc (fibOf x b) := by

  change ((secDiag W Q x + secA Q x + secB Q x : Sec ι)) a = _
  rw [lp.coeFn_add, lp.coeFn_add]
  rfl
