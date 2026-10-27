-- Generated from ChapterThermalMaxEntropy.lean — solution of BookProof.ChapterThermalMaxEntropy.log_thermalProb
import Mathlib
import Definitions.Def_ChapterThermalMaxEntropy
open BookProof.ChapterThermalMaxEntropy



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {nbar : ℝ}

variable {nbar : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 < nbar) (n : ℕ) :
    Real.log (thermalProb nbar n)
      = -Real.log (nbar + 1) + (n : ℝ) * Real.log (thermalRatio nbar) := by

  have h1 : 0 < nbar + 1 := by linarith
  have hr : 0 < thermalRatio nbar := div_pos h h1
  rw [thermalProb, Real.log_mul (by positivity) (by positivity), Real.log_pow, one_div,
    Real.log_inv]
