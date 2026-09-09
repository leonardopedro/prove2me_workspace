-- Generated from ChapterSirkRestart.lean — theorem BookProof.ChapterSirkRestart.restart_error_accumulation
import Mathlib
import Definitions.Def_ChapterSirkRestart
open BookProof.ChapterSirkRestart







noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.ChapterSirkRestart.restart_error_accumulation (U S : E →L[ℂ] E) (eps : ℝ)
    (hU : ∀ w : E, ‖U w‖ ≤ ‖w‖) (hS : ∀ w : E, ‖S w‖ ≤ ‖w‖)
    (hstep : ∀ w : E, ‖U w - S w‖ ≤ eps * ‖w‖)
    (n : ℕ) (v : E) :
    ‖(U ^ n) v - (S ^ n) v‖ ≤ n * eps * ‖v‖ := by sorry
