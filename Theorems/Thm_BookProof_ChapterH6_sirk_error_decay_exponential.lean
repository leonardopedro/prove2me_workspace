-- Generated from ChapterH6.lean — theorem BookProof.ChapterH6.sirk_error_decay_exponential
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem BookProof.ChapterH6.sirk_error_decay_exponential (C Dmin h nv : ℝ) (hh : 0 < h) :
    Tendsto (fun m : ℕ => sirkBound C Dmin h nv m) atTop (𝓝 0) := by sorry