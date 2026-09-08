-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.integrable_poly_mul_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore









open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : Polynomial ℝ) :
    Integrable (fun x : ℝ => p.eval x * gaussH x) := by

  have h := integrable_poly_mul_exp_neg p (b := 1 / 4) (by norm_num)
  refine h.congr (Filter.Eventually.of_forall fun x => ?_)
  simp only [gaussH]
  ring_nf
