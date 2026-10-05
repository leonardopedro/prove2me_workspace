-- Generated from ChapterFreeFieldBornFiberBounds.lean — solution of BookProof.ChapterFreeFieldBornFiberBounds.bornFiber_card_bounds
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberBounds
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberBounds_bornFiber_card_le_two_pow_n
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberTwo_two_le_bornFiber_card
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
    2 ≤ Nat.card ↥(bornMapSphere n ⁻¹' {p}) ∧
      Nat.card ↥(bornMapSphere n ⁻¹' {p}) ≤ 2 ^ n := ⟨two_le_bornFiber_card, bornFiber_card_le_two_pow_n⟩
