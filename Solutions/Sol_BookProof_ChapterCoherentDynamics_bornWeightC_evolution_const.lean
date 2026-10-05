-- Generated from ChapterCoherentDynamics.lean — solution of BookProof.ChapterCoherentDynamics.bornWeightC_evolution_const
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
import Theorems.Thm_BookProof_ChapterCoherentDynamics_bornWeightC_phaseRotate
open BookProof.ChapterCoherentDynamics



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (omega : ℝ) (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) (t : ℝ) :
    bornWeightC (phaseRotate (-(omega * t)) q)
        (fun l => phaseRotate (-(omega * t)) (k l)) j
      = bornWeightC q k j := bornWeightC_phaseRotate _ q k j
