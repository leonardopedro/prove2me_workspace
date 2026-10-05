-- Generated from ChapterCoherentDynamics.lean — solution of BookProof.ChapterCoherentDynamics.bornWeightC_phaseRotate
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
import Theorems.Thm_BookProof_ChapterCoherentDynamics_bornNumerC_phaseRotate
open BookProof.ChapterCoherentDynamics



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (theta : ℝ) (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC (phaseRotate theta q) (fun l => phaseRotate theta (k l)) j
      = bornWeightC q k j := by

  rw [bornWeightC, bornWeightC, bornNumerC_phaseRotate]
  congr 1
  exact Finset.sum_congr rfl fun l _ => bornNumerC_phaseRotate theta q (k l)
