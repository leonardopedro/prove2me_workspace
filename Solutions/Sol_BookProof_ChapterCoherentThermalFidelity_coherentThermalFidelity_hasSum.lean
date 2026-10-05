-- Generated from ChapterCoherentThermalFidelity.lean — solution of BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_hasSum
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
open BookProof.ChapterCoherentThermalFidelity



noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real

variable {nbar lam : ℝ}

variable {nbar lam : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 ≤ nbar) (lam : ℝ) :
    HasSum (fun n : ℕ => coherentOccupation lam n * thermalProb nbar n)
      (Real.exp (-(lam / (nbar + 1))) / (nbar + 1)) := by

  have hpos : (0 : ℝ) < nbar + 1 := by linarith
  have hkey := (hasSum_expSeries (lam * thermalRatio nbar)).mul_left
    (Real.exp (-lam) * (1 / (nbar + 1)))
  have hval : Real.exp (-lam) * (1 / (nbar + 1)) * Real.exp (lam * thermalRatio nbar)
      = Real.exp (-(lam / (nbar + 1))) / (nbar + 1) := by
    rw [mul_comm (Real.exp (-lam)) (1 / (nbar + 1)), mul_assoc, ← Real.exp_add]
    rw [thermalRatio]
    rw [show -lam + lam * (nbar / (nbar + 1)) = -(lam / (nbar + 1)) by
      field_simp; ring]
    ring
  rw [hval] at hkey
  refine hkey.congr_fun fun n => ?_
  rw [coherentOccupation_eq, thermalProb, mul_pow]
  ring
