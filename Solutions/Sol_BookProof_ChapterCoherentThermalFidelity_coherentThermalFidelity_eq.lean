-- Generated from ChapterCoherentThermalFidelity.lean — solution of BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_eq
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
import Theorems.Thm_BookProof_ChapterCoherentThermalFidelity_coherentThermalFidelity_hasSum
open BookProof.ChapterCoherentThermalFidelity



noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real

variable {nbar lam : ℝ}

variable {nbar lam : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 ≤ nbar) (lam : ℝ) :
    coherentThermalFidelity nbar lam = Real.exp (-(lam / (nbar + 1))) / (nbar + 1) := (coherentThermalFidelity_hasSum h lam).tsum_eq
