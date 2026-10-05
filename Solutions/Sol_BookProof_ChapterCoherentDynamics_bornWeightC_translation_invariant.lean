-- Generated from ChapterCoherentDynamics.lean — solution of BookProof.ChapterCoherentDynamics.bornWeightC_translation_invariant
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
import Theorems.Thm_BookProof_ChapterCoherentFidelity_fidelityC_eq_bornNumerC
import Theorems.Thm_BookProof_ChapterCoherentFidelity_fidelityC_translation_invariant
open BookProof.ChapterCoherentDynamics



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC (q + v) (fun l => k l + v) j = bornWeightC q k j := by

  have hnum : ∀ l : Fin m, bornNumerC (q + v) (k l + v) = bornNumerC q (k l) := by
    intro l
    rw [← fidelityC_eq_bornNumerC, ← fidelityC_eq_bornNumerC,
      fidelityC_translation_invariant]
  rw [bornWeightC, bornWeightC, hnum j]
  congr 1
  exact Finset.sum_congr rfl fun l _ => hnum l
