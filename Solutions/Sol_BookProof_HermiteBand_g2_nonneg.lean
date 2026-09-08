-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.g2_nonneg
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

























open BookProof.NavierStokesFlow.DifferentialL2 BookProof.FullQuadratic

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : 0 ≤ g2 n := by

  simp only [g2]
  positivity
