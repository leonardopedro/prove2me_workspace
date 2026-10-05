-- Generated from ChapterFreeFieldBornSignAction.lean — theorem BookProof.ChapterFreeFieldBornSignAction.boolFlip_comp
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignAction

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge



theorem BookProof.ChapterFreeFieldBornSignAction.boolFlip_comp (b₁ b₂ : Fin n → Bool) (x : EuclideanSpace ℝ (Fin n)) :
    boolFlip b₁ (boolFlip b₂ x) = boolFlip (fun k => xor (b₁ k) (b₂ k)) x := by sorry
