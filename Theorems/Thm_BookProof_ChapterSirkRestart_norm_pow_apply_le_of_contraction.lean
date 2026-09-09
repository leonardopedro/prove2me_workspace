-- Generated from ChapterSirkRestart.lean — theorem BookProof.ChapterSirkRestart.norm_pow_apply_le_of_contraction
import Mathlib
import Definitions.Def_ChapterSirkRestart
open BookProof.ChapterSirkRestart







noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.ChapterSirkRestart.norm_pow_apply_le_of_contraction (S : E →L[ℂ] E) (hS : ∀ w : E, ‖S w‖ ≤ ‖w‖)
    (n : ℕ) (v : E) : ‖(S ^ n) v‖ ≤ ‖v‖ := by sorry
