-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.gint_add
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore









open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p q : Polynomial ℝ) : gint (p + q) = gint p + gint q := by

  simp only [gint, Polynomial.eval_add, add_mul]
  exact integral_add (integrable_poly_mul_gaussW p) (integrable_poly_mul_gaussW q)
