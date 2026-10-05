-- Generated from ChapterFreeFieldBornSignAction.lean — theorem BookProof.ChapterFreeFieldBornSignAction.boolFlip_free_of_pos
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignAction

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge



theorem BookProof.ChapterFreeFieldBornSignAction.boolFlip_free_of_pos {b : Fin n → Bool} {x : EuclideanSpace ℝ (Fin n)}
    (hx : ∀ k, x k ≠ 0) :
    boolFlip b x = x ↔ b = (fun _ => false) := by sorry
