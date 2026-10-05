-- Generated from ChapterCoherentThermalFidelity.lean — solution of BookProof.ChapterCoherentThermalFidelity.fidelityC_width
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
import Theorems.Thm_BookProof_ChapterCoherentFidelity_fidelityC_eq_exp_neg_dist_sq
open BookProof.ChapterCoherentThermalFidelity



noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real

variable {nbar lam : ℝ}

variable {nbar lam : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (q k : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k = Real.exp (-(‖q - k‖ ^ 2 / (coherentWidth + coherentWidth))) := by

  rw [fidelityC_eq_exp_neg_dist_sq, coherentWidth]
  norm_num
