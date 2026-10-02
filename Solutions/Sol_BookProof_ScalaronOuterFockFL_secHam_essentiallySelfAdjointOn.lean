-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.secHam_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_symmetricOn
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_commForm_le
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secData_coreN
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_essentiallySelfAdjointOn
import Theorems.Thm_BookProof_QgOuterFockCoreFL_commForm_congr
import Theorems.Thm_BookProof_QgOuterFockCoreFL_quadForm_congr




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
theorem solution :
    EssentiallySelfAdjointOn (secN W Q).dom (secData W Q).ext := by

  refine (secData W Q).ext_essentiallySelfAdjointOn (secHam_symmetricOn W Q)
    (c := 6 * Q.K) (by have := Q.K_nonneg; linarith) ?_
  intro p
  have hc : commForm (secData W Q).H₀ (secData W Q).coreN p
      = commForm (secHam W Q) (secDiag W Q) p :=
    commForm_congr _ _ _ _ _ _ rfl (secData_coreN W Q p)
  have hq : quadForm (secData W Q).coreN p = quadForm (secDiag W Q) p :=
    quadForm_congr _ _ _ _ rfl (secData_coreN W Q p)
  rw [hc, hq]
  exact secHam_commForm_le W Q p
