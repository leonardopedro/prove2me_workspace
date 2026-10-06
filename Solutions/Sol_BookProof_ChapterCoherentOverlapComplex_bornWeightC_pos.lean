-- Generated from ChapterCoherentOverlapComplex.lean — solution of BookProof.ChapterCoherentOverlapComplex.bornWeightC_pos
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
import Theorems.Thm_BookProof_ChapterCoherentOverlapComplex_bornNumerC_pos
import Theorems.Thm_BookProof_ChapterCoherentOverlapComplex_bornDenomC_pos
open BookProof.ChapterCoherentOverlapComplex



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℂ (Fin n)) (k : Fin m → EuclideanSpace ℂ (Fin n))
    (j : Fin m) : 0 < bornWeightC q k j := div_pos (bornNumerC_pos q (k j)) (bornDenomC_pos q k j)
