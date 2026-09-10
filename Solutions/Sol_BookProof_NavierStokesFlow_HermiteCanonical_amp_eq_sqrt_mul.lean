-- Generated from ChapterNavierStokesHermiteCanonical.lean — solution of BookProof.NavierStokesFlow.HermiteCanonical.amp_eq_sqrt_mul
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical








open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine
























variable {κ : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (κ : ℝ) (n : ℕ) :
    amp κ n = (κ / 2) * (Real.sqrt ((n : ℝ) + 1) * Real.sqrt ((n : ℝ) + 2)) := by

  rw [amp, ← Real.sqrt_mul (by positivity)]
