-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.norm_sq_le_quadForm
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronFiberFL_WallPot_one_le_pot
import Theorems.Thm_BookProof_ScalaronFiberFL_cc_integrable
import Theorems.Thm_BookProof_ScalaronFiberFL_cc_integrable_sq
import Theorems.Thm_BookProof_WallEsaSemibounded_ccEquiv_norm_sq
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (s : ℝ) (hs : 1 ≤ s) (f : ccSchwartz ℝ) :
    ‖((ccEquiv ℝ f : ccDomain ℝ) : L2R)‖ ^ 2 ≤ quadForm (W.ham s) (ccEquiv ℝ f) := by

  rw [ccEquiv_norm_sq, ham_quadForm]
  have hmono : (∫ x, ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2)
      ≤ ∫ x, W.pot s x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
    refine integral_mono (cc_integrable_sq f) (cc_integrable f (W.pot_smooth s).continuous)
      fun x => ?_
    have h1 := W.one_le_pot s hs x
    nlinarith [sq_nonneg ‖(f : 𝓢(ℝ, ℂ)) x‖]
  have h1 := integral_deriv_nonneg f
  linarith
