-- Generated from ChapterHermiteProductBasis.lean — solution of BookProof.HermiteProductBasis.hermiteNorm_succ
import Mathlib
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.HermiteProductBasis








open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    hermiteNorm (n + 1) = hermiteNorm n * Real.sqrt ((n : ℝ) + 1) := by

  have hfac : ((n + 1).factorial : ℝ) * Real.sqrt (2 * Real.pi)
      = ((n : ℝ) + 1) * ((n.factorial : ℝ) * Real.sqrt (2 * Real.pi)) := by
    rw [Nat.factorial_succ]
    push_cast
    ring
  rw [hermiteNorm, hermiteNorm, hfac, Real.sqrt_mul (by positivity), mul_comm]
