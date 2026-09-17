-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.norm_sub_starProjection_antitone
import Mathlib
import Definitions.Def_ChapterH9
import Theorems.Thm_BookProof_ChapterH9_norm_sub_starProjection_le
open BookProof.ChapterH9



noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution (K L : Submodule ℂ E)
    [K.HasOrthogonalProjection] [L.HasOrthogonalProjection] (hKL : K ≤ L) (v : E) :
    ‖v - L.starProjection v‖ ≤ ‖v - K.starProjection v‖ := norm_sub_starProjection_le L v (K.starProjection v) (hKL (K.starProjection_apply_mem v))
