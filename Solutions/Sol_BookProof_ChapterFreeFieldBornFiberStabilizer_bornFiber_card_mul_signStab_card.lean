-- Generated from ChapterFreeFieldBornFiberStabilizer.lean — solution of BookProof.ChapterFreeFieldBornFiberStabilizer.bornFiber_card_mul_signStab_card
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberStabilizer
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberStabilizer_signStab_card_mul_two_pow_nonzero
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberStabilizer_posSupport_bornMap
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberCardGeneral_bornFiber_card_general
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
theorem solution
    (x : ↥(Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1)) :
    Nat.card ↥(bornMapSphere n ⁻¹' {bornMapSphere n x}) *
        (signStab (x : EuclideanSpace ℝ (Fin n))).card = 2 ^ n := by

  rw [mul_comm, ← signStab_card_mul_two_pow_nonzero]
  congr 1
  rw [bornFiber_card_general, bornMapSphere_coe, posSupport_bornMap]
