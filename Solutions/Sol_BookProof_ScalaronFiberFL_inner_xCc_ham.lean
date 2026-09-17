-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.inner_xCc_ham
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronFiberFL_hamS_apply
import Theorems.Thm_BookProof_ScalaronFiberFL_ham_eq_toLp
import Theorems.Thm_BookProof_ScalaronFiberFL_xCc_eq_toLp
import Theorems.Thm_BookProof_ScalaronFiberFL_inner_toLp_toLp
import Theorems.Thm_BookProof_ScalaronEsa_mulCc_apply
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (s : ℝ) (f g : ccSchwartz ℝ) :
    (inner ℂ (xCc (ccEquiv ℝ g)) (W.ham s (ccEquiv ℝ f)) : ℂ)
      = ∫ y : ℝ, (y : ℂ) * ((starRingEnd ℂ) ((g : 𝓢(ℝ, ℂ)) y)
          * (-deriv (deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ)) y
            + (W.pot s y : ℂ) * (f : 𝓢(ℝ, ℂ)) y)) := by

  rw [xCc_eq_toLp, ham_eq_toLp, inner_toLp_toLp]
  refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
  change (starRingEnd ℂ) ((mulCc (fun x : ℝ => x) contDiff_id g) y) * (hamS W s f) y = _
  rw [mulCc_apply, hamS_apply]
  simp only [map_mul, Complex.conj_ofReal]
  ring
