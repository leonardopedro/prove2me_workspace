-- Generated from ChapterSirkRestart.lean — theorem BookProof.ChapterSirkRestart.brst_leakage_bound
import Mathlib
import Definitions.Def_ChapterSirkRestart
open BookProof.ChapterSirkRestart







noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.ChapterSirkRestart.brst_leakage_bound (U S Om : E →L[ℂ] E) (eps : ℝ)
    (hU : ∀ w : E, ‖U w‖ ≤ ‖w‖) (hS : ∀ w : E, ‖S w‖ ≤ ‖w‖)
    (hstep : ∀ w : E, ‖U w - S w‖ ≤ eps * ‖w‖)
    (hcomm : Om.comp U = U.comp Om)
    (n : ℕ) (v : E) (hv : Om v = 0) :
    ‖Om ((S ^ n) v)‖ ≤ ‖Om‖ * (n * eps * ‖v‖) := by sorry
