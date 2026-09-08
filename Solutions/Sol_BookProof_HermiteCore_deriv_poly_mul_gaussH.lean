-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.deriv_poly_mul_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hasDerivAt_poly_mul_gaussH
open BookProof.HermiteCore









open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : Polynomial ℝ) :
    deriv (fun y : ℝ => p.eval y * gaussH y)
      = fun x : ℝ => (derivative p - C (1 / 2 : ℝ) * (X * p)).eval x * gaussH x := funext fun x => (hasDerivAt_poly_mul_gaussH p x).deriv
