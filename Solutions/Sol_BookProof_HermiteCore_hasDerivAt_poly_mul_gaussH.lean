-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hasDerivAt_poly_mul_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hasDerivAt_gaussH
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
n_dense

theorem solution (n : ℕ) : hermiteBasis n = hermiteLp n := by
  rw [hermiteBasis, HilbertBasis.coe_mk]

/-! ## The harmonic oscillator -/

/-- The first derivative of a Hermite function. -/
theorem hasDerivAt_hermiteFun (n : ℕ) (x : ℝ) : :=
     HasDerivAt (hermiteFun n)
        (((derivative (hermiteR n)).eval x - x / 2 * (hermiteR n).eval x) * gaussH x) x := by
    have h := ((hermiteR n).hasDerivAt x).mul (hasDerivAt_gau
