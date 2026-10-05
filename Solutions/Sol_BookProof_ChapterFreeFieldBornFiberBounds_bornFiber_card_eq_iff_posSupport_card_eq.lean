-- Generated from ChapterFreeFieldBornFiberBounds.lean — solution of BookProof.ChapterFreeFieldBornFiberBounds.bornFiber_card_eq_iff_posSupport_card_eq
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberBounds
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
theorem solution
    {p q : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) = Nat.card ↥(bornMapSphere n ⁻¹' {q}) ↔
      (posSupport (p : Fin n → ℝ)).card = (posSupport (q : Fin n → ℝ)).card := by

  rw [bornFiber_card_general, bornFiber_card_general]
  exact (Nat.pow_right_injective (le_refl 2)).eq_iff
