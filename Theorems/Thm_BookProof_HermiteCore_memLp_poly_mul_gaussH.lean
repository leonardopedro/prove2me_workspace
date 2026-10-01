-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.memLp_poly_mul_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

r (by positivity)

theorem BookProof.HermiteCore.memLp_poly_mul_gaussH (n : ℕ) :
    hermiteNorm n * hermiteNorm n = (n.factorial : ℝ) * Real.sqrt (2 * Real.pi) := by
  have h : (0 : ℝ) ≤ (n.factorial : ℝ) * Real.sqrt (2 * Real. := by sorry
