-- Generated from ChapterCoherentOverlapComplex.lean — solution of BookProof.ChapterCoherentOverlapComplex.bornWeightC_phase_invariant
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
import Theorems.Thm_BookProof_ChapterCoherentOverlapComplex_coherentBornC_cancel_q
open BookProof.ChapterCoherentOverlapComplex



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℂ (Fin n))
    (k k' : Fin m → EuclideanSpace ℂ (Fin n)) (hnorm : ∀ l, ‖k' l‖ = ‖k l‖)
    (hre : ∀ l, (inner ℂ q (k' l) : ℂ).re = (inner ℂ q (k l) : ℂ).re) (j : Fin m) :
    bornWeightC q k' j = bornWeightC q k j := by

  rw [coherentBornC_cancel_q, coherentBornC_cancel_q, hnorm j, hre j]
  congr 1
  exact Finset.sum_congr rfl fun l _ => by rw [hnorm l, hre l]
