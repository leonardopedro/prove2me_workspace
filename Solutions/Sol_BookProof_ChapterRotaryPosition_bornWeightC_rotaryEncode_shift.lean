-- Generated from ChapterRotaryPosition.lean — solution of BookProof.ChapterRotaryPosition.bornWeightC_rotaryEncode_shift
import Mathlib
import Definitions.Def_ChapterRotaryPosition
import Theorems.Thm_BookProof_ChapterRotaryPosition_bornNumerC_rotaryEncode_shift
open BookProof.ChapterRotaryPosition



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (omega : Fin n → ℝ) (a c : ℝ)
    (pos : Fin m → ℝ) (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC (rotaryEncode omega (a + c) q)
        (fun l => rotaryEncode omega (pos l + c) (k l)) j
      = bornWeightC (rotaryEncode omega a q) (fun l => rotaryEncode omega (pos l) (k l)) j := by

  have hnum : ∀ l : Fin m,
      bornNumerC (rotaryEncode omega (a + c) q) (rotaryEncode omega (pos l + c) (k l))
        = bornNumerC (rotaryEncode omega a q) (rotaryEncode omega (pos l) (k l)) :=
    fun l => bornNumerC_rotaryEncode_shift omega a (pos l) c q (k l)
  rw [bornWeightC, bornWeightC, hnum j]
  congr 1
  exact Finset.sum_congr rfl fun l _ => hnum l
