-- Generated from ChapterNavierStokesHermiteCanonical.lean — solution of BookProof.NavierStokesFlow.HermiteCanonical.drift_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical








open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine
























variable {κ : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 < κ) : drift κ = (κ : ℂ) • pos κ := by

  rw [drift, pos, smul_smul]
  congr 1
  have hne : Real.sqrt (2 * κ) ≠ 0 := Real.sqrt_ne_zero'.mpr (by linarith)
  have hmul : Real.sqrt (κ / 2) * Real.sqrt (2 * κ) = κ := by
    rw [← Real.sqrt_mul (by positivity)]
    have hsq : κ / 2 * (2 * κ) = κ ^ 2 := by ring
    rw [hsq, Real.sqrt_sq hκ.le]
  have hreal : Real.sqrt (κ / 2) = κ * (1 / Real.sqrt (2 * κ)) := by
    rw [eq_comm, mul_one_div, div_eq_iff hne]
    exact hmul.symm
  rw [← Complex.ofReal_mul, ← hreal]
