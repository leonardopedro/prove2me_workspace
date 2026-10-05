-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.norm_dCc_sq_le_cc
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronOuterFockFL_dCc_eq
import Theorems.Thm_BookProof_ScalaronFiberFL_norm_derivL2_sq_le
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (hs : 0 ≤ s) (u : ccDomain ℝ) :
    ‖dCc u‖ ^ 2 ≤ quadForm (W.ham s) u := by

  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective u
  rw [dCc_eq]
  exact norm_derivL2_sq_le W s hs f
