-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.deriv_poly_mul_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore








open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.deriv_poly_mul_gaussH (p : Polynomial ℝ) :
    deriv (fun y : ℝ => p.eval y * gaussH y)
      = fun x : ℝ => (derivative p - C (1 / 2 : ℝ) * (X * p)).eval x * gaussH x := by sorry
