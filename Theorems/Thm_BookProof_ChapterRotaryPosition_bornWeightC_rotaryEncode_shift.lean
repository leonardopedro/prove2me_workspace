-- Generated from ChapterRotaryPosition.lean — theorem BookProof.ChapterRotaryPosition.bornWeightC_rotaryEncode_shift
import Mathlib
import Definitions.Def_ChapterRotaryPosition
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex
open BookProof.ChapterRotaryPosition

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex


theorem BookProof.ChapterRotaryPosition.bornWeightC_rotaryEncode_shift (omega : Fin n → ℝ) (a c : ℝ)
    (pos : Fin m → ℝ) (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC (rotaryEncode omega (a + c) q)
        (fun l => rotaryEncode omega (pos l + c) (k l)) j
      = bornWeightC (rotaryEncode omega a q) (fun l => rotaryEncode omega (pos l) (k l)) j := by sorry
