-- Generated from ChapterFreeFieldBornSignAction.lean — solution of BookProof.ChapterFreeFieldBornSignAction.boolFlip_free_of_pos
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignAction
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignAction_boolFlip_eq_self_iff
open BookProof.ChapterFreeFieldBornSignAction



open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {b : Fin n → Bool} {x : EuclideanSpace ℝ (Fin n)}
    (hx : ∀ k, x k ≠ 0) :
    boolFlip b x = x ↔ b = (fun _ => false) := by

  rw [boolFlip_eq_self_iff]; aesop
