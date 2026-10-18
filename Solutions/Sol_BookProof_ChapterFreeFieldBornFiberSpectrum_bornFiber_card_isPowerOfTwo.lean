-- Generated from ChapterFreeFieldBornFiberSpectrum.lean — solution of BookProof.ChapterFreeFieldBornFiberSpectrum.bornFiber_card_isPowerOfTwo
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberSpectrum
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberBounds_posSupport_card_le_n
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberTwo_one_le_posSupport_card
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterFreeFieldBornCont
import Definitions.Def_ChapterFreeFieldBornQuotient
import Definitions.Def_ChapterFreeFieldBornFiberCardGeneral
import Definitions.Def_ChapterFreeFieldBornFiberTwo
import Definitions.Def_ChapterFreeFieldBornFiberBounds
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
    ∃ k, 1 ≤ k ∧ k ≤ n ∧ Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ^ k := by

  exact ⟨ _, BookProof.ChapterFreeFieldBornFiberTwo.one_le_posSupport_card p.2,
      BookProof.ChapterFreeFieldBornFiberBounds.posSupport_card_le_n,
          BookProof.ChapterFreeFieldBornFiberCardGeneral.bornFiber_card_general ⟩
