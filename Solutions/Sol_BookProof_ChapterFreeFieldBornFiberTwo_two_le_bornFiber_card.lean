-- Generated from ChapterFreeFieldBornFiberTwo.lean — solution of BookProof.ChapterFreeFieldBornFiberTwo.two_le_bornFiber_card
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberTwo
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberTwo_one_le_posSupport_card
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberCardGeneral_bornFiber_card_general
open BookProof.ChapterFreeFieldBornFiberTwo



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : ↥(stdSimplex ℝ (Fin n))} :
    2 ≤ Nat.card ↥(bornMapSphere n ⁻¹' {p}) := by

  convert Nat.pow_le_pow_right ( by decide : 1 ≤ 2 ) ( one_le_posSupport_card p.2 ) using 1;
  convert bornFiber_card_general
  rfl
