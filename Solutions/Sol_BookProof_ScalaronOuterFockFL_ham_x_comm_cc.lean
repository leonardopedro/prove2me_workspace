-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.ham_x_comm_cc
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronOuterFockFL_dCc_eq
import Theorems.Thm_BookProof_ScalaronFiberFL_ham_x_comm
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
theorem solution (u v : ccDomain ℝ) :
    (starRingEnd ℂ) (inner ℂ (xCc v) (W.ham s u) : ℂ) - (inner ℂ (xCc u) (W.ham s v) : ℂ)
      = -2 * (inner ℂ (u : L2R) (dCc v) : ℂ) := by

  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective u
  obtain ⟨g, rfl⟩ := (ccEquiv ℝ).surjective v
  rw [dCc_eq]
  exact ham_x_comm W s f g
