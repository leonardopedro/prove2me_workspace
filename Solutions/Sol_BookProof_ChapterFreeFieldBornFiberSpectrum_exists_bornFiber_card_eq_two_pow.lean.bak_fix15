-- Generated from ChapterFreeFieldBornFiberSpectrum.lean — solution of BookProof.ChapterFreeFieldBornFiberSpectrum.exists_bornFiber_card_eq_two_pow
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberSpectrum
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberSpectrum_unifDist_mem_simplex
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberSpectrum_posSupport_unifDist_card
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
theorem solution {k : ℕ} (hk : 1 ≤ k) (hkn : k ≤ n) :
    ∃ p : ↥(stdSimplex ℝ (Fin n)),
      Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ^ k := by

  use ⟨unifDist n k, unifDist_mem_simplex hk hkn⟩;
  convert bornFiber_card_general;
  exact Eq.symm ( posSupport_unifDist_card hk hkn )
