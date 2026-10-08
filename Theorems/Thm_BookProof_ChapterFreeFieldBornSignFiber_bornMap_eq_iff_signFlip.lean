-- Generated from ChapterFreeFieldBornSignFiber.lean — theorem BookProof.ChapterFreeFieldBornSignFiber.bornMap_eq_iff_signFlip
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignFiber
open BookProof.ChapterFreeFieldBornSignFiber


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSignGauge


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldBornSignFiber.bornMap_eq_iff_signFlip (x y : EuclideanSpace ℝ (Fin n)) :
    bornMap y = bornMap x ↔
      ∃ s : Fin n → ℝ, (∀ k, s k = 1 ∨ s k = -1) ∧ y = signFlip s x := by sorry
