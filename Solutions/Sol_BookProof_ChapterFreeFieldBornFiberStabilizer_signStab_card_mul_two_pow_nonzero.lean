-- Generated from ChapterFreeFieldBornFiberStabilizer.lean — solution of BookProof.ChapterFreeFieldBornFiberStabilizer.signStab_card_mul_two_pow_nonzero
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberStabilizer
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberStabilizer_signStab_card
open BookProof.ChapterFreeFieldBornFiberStabilizer



open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberBounds


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (x : EuclideanSpace ℝ (Fin n)) :
    (signStab x).card * 2 ^ (Finset.univ.filter (fun k => x k ≠ 0)).card = 2 ^ n := by

      rw [ signStab_card, ← pow_add, Finset.card_filter_add_card_filter_not ];
      norm_num
