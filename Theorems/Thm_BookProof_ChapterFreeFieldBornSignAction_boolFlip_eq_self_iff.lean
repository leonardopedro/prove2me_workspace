-- Generated from ChapterFreeFieldBornSignAction.lean — theorem BookProof.ChapterFreeFieldBornSignAction.boolFlip_eq_self_iff
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignAction


open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldBornSignAction.boolFlip_eq_self_iff {b : Fin n → Bool} {x : EuclideanSpace ℝ (Fin n)} :
    boolFlip b x = x ↔ ∀ k, x k ≠ 0 → b k = false := by sorry
