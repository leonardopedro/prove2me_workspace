-- Generated from ChapterFreeFieldBornFiberBounds.lean — solution of BookProof.ChapterFreeFieldBornFiberBounds.bornFiber_card_le_two_pow_n
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberBounds
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberBounds_posSupport_card_le_n
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberCardGeneral_bornFiber_card_general
open BookProof.ChapterFreeFieldBornFiberBounds



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberTwo


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) ≤ 2 ^ n := by

  rw [bornFiber_card_general]
  exact Nat.pow_le_pow_right (by decide) posSupport_card_le_n
