-- Generated from ChapterCoherentThermalFidelity.lean — solution of BookProof.ChapterCoherentThermalFidelity.width_unique
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
import Theorems.Thm_BookProof_ChapterCoherentThermalFidelity_coherentThermalFidelity_eq
open BookProof.ChapterCoherentThermalFidelity



noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real

variable {nbar lam : ℝ}

variable {nbar lam : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 ≤ nbar) {w : ℝ} (hw : 0 < w)
    (hfid : ∀ lam : ℝ, coherentThermalFidelity nbar lam = Real.exp (-(lam / w)) / w) :
    w = nbar + 1 := by

  have hpos : (0 : ℝ) < nbar + 1 := by linarith
  have h0 := hfid 0
  rw [coherentThermalFidelity_eq h] at h0
  simp only [zero_div, neg_zero, Real.exp_zero] at h0
  field_simp at h0
  linarith
