-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.gint_one
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
gaussW q)

theorem solution (p q : Polynomial ℝ) : :=
   gint (p - q) = gint p - gint q := by
    simp only [gint, Polynomial.eval_sub, sub_mul]
    exact integral_sub (integrable_poly_mul_gaussW p) (integrable_poly_mul_gaussW q)
  
  theorem gint_C_mul (c : ℝ) (p : Polynomial ℝ) : gint (C c * p) = c * gint p := by
    simp only [gint, Polynomial.eval_mul, Polynomial.eval_C, mu
