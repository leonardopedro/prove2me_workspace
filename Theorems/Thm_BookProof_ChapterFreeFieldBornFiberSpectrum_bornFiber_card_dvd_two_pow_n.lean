-- Generated from ChapterFreeFieldBornFiberSpectrum.lean — theorem BookProof.ChapterFreeFieldBornFiberSpectrum.bornFiber_card_dvd_two_pow_n
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberSpectrum
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornFiberSpectrum

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornFiberCardGeneral



theorem BookProof.ChapterFreeFieldBornFiberSpectrum.bornFiber_card_dvd_two_pow_n {p : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) ∣ 2 ^ n := by sorry
