-- Generated from ChapterFreeFieldBornFiberCardGeneral.lean — solution of BookProof.ChapterFreeFieldBornFiberCardGeneral.bornFiber_card_general
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberCardGeneral



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornSignFiber BookProof.ChapterFreeFieldBornSectionBij
open BookProof.ChapterFreeFieldBornQuotient BookProof.ChapterFreeFieldBornFiberCard


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ^ (posSupport (p : Fin n → ℝ)).card := by

  convert Nat.card_congr ( bornFiberEquivGeneral.symm ) using 1
  rw [ Nat.card_eq_fintype_card, Fintype.card_pi ]
  norm_num
