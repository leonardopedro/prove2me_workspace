-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.norm_xCc_sq_le
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronFiberFL_WallPot_sq_div_four_le_pot
import Theorems.Thm_BookProof_ScalaronFiberFL_cc_integrable
import Theorems.Thm_BookProof_ScalaronFiberFL_norm_xCc_sq
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (s : ℝ) (hs : 0 ≤ s) (f : ccSchwartz ℝ) :
    ‖xCc (ccEquiv ℝ f)‖ ^ 2 ≤ 4 * quadForm (W.ham s) (ccEquiv ℝ f) := by

  rw [norm_xCc_sq, ham_quadForm]
  have hmono : (∫ x, x ^ 2 / 4 * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2)
      ≤ ∫ x, W.pot s x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
    refine integral_mono (cc_integrable f (by fun_prop))
      (cc_integrable f (W.pot_smooth s).continuous) fun x => ?_
    have h1 := W.sq_div_four_le_pot s hs x
    nlinarith [sq_nonneg ‖(f : 𝓢(ℝ, ℂ)) x‖]
  have hsplit : (∫ x, x ^ 2 * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2)
      = 4 * ∫ x, x ^ 2 / 4 * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
    rw [← integral_const_mul]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  have h1 := integral_deriv_nonneg f
  rw [hsplit]
  linarith
