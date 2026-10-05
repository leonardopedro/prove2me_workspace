-- Generated from ChapterFreeFieldBornFiberSpectrum.lean — solution of BookProof.ChapterFreeFieldBornFiberSpectrum.bornFiber_card_dvd_two_pow_n
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberSpectrum
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberBounds_posSupport_card_le_n
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberCardGeneral_bornFiber_card_general
open BookProof.ChapterFreeFieldBornFiberSpectrum



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberTwo
open BookProof.ChapterFreeFieldBornFiberBounds


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) ∣ 2 ^ n := by

  rw [bornFiber_card_general]
  exact pow_dvd_pow 2 posSupport_card_le_n
