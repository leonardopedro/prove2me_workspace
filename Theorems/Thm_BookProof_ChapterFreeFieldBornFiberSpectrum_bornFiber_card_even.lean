-- Generated from ChapterFreeFieldBornFiberSpectrum.lean — theorem BookProof.ChapterFreeFieldBornFiberSpectrum.bornFiber_card_even
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberSpectrum
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornFiberSpectrum

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornFiberCardGeneral



theorem BookProof.ChapterFreeFieldBornFiberSpectrum.bornFiber_card_even {p : ↥(stdSimplex ℝ (Fin n))} :
    2 ∣ Nat.card ↥(bornMapSphere n ⁻¹' {p}) := by sorry
