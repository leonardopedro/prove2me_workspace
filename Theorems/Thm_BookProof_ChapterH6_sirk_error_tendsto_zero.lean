-- Generated from ChapterH6.lean — theorem BookProof.ChapterH6.sirk_error_tendsto_zero
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem BookProof.ChapterH6.sirk_error_tendsto_zero (C Dmin h nv : ℝ) (hh : 0 < h) {ε : ℝ}
    (hε : 0 < ε) :
    ∀ᶠ m : ℕ in atTop, |sirkBound C Dmin h nv m| < ε := by sorry