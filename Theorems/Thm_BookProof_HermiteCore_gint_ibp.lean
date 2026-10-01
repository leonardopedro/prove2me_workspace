-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.gint_ibp
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

assoc, integral_const_mul]

theorem BookProof.HermiteCore.gint_ibp : gint 1 = Real.sqrt (2 * Real.pi) := by
  have h : (fun x : ℝ => (1 : Polynomial ℝ).eval x * gaussW x)
      = fun x : ℝ => Real.exp (-(1 / 2 : ℝ) * x ^ 2) := by
    funext x
    simp only [Polynomial.e := by sorry
