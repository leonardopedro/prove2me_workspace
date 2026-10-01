-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hasDerivAt_poly_mul_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

n_dense

theorem BookProof.HermiteCore.hasDerivAt_poly_mul_gaussH (n : ℕ) : hermiteBasis n = hermiteLp n := by
  rw [hermiteBasis, HilbertBasis.coe_mk]

/-! ## The harmonic oscillator -/

/-- The first derivative of a Hermite function. -/
theorem hasDerivAt_hermiteFun (n : ℕ) (x : ℝ) : := by sorry
