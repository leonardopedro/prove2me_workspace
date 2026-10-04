-- Generated from ChapterFreeFieldBornFiberSpectrum.lean — theorem BookProof.ChapterFreeFieldBornFiberSpectrum.exists_bornFiber_card_eq_two_pow
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberSpectrum
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornFiberSpectrum

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornFiberCardGeneral



theorem BookProof.ChapterFreeFieldBornFiberSpectrum.exists_bornFiber_card_eq_two_pow {k : ℕ} (hk : 1 ≤ k) (hkn : k ≤ n) :
    ∃ p : ↥(stdSimplex ℝ (Fin n)),
      Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ^ k := by sorry
